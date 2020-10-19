//
//  GameBoard.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit
import UIKit
import CoreData

enum BoardState {
  case inPlay, notInPlay, paused, gameOver
}


class GameBoard: SKShapeNode {
  
  private let numberOfBlocksWide: CGFloat = 12
  private let screenWidthAmount: CGFloat = 0.9
  private var screenHieghtAmount: CGFloat = 0.7
  
  var boardState: BoardState = .notInPlay
  var columnWidth: CGFloat = 0
  var xPositions: [CGFloat] = []
  var yPositions: [CGFloat] = []
  var occupiedPositions: [CGFloat : Set<CGFloat>] = [:]
  var activeGamePiece: TetrisPiece?
  
  var currentLevelSpeed = 40
  var gameSpeed = 40
  
  var setPiecesNode = SKNode()
  
  func prepareForUIUpdate() {
    boardState = .paused
    let defaults = (UIApplication.shared.delegate as! AppDelegate).defaults
    defaults.set(occupiedPositions, forKey: "occupiedPositions")
    defaults.set(activeGamePiece, forKey: "activeGamePiece")
    defaults.set(currentLevelSpeed, forKey: "currentLevelSpeed")
    defaults.set(gameSpeed, forKey: "gameSpeed")
    defaults.set(setPiecesNode, forKey: "setPiecesNode")
  }
  
  func restoreFromUIUpdate() {
    let defaults = (UIApplication.shared.delegate as! AppDelegate).defaults
    occupiedPositions = defaults.object(forKey: "occupiedPositions") as! [CGFloat : Set<CGFloat>]
    activeGamePiece = defaults.object(forKey: "activeGamePiece") as! TetrisPiece
    currentLevelSpeed = defaults.integer(forKey: "currentLevelSpeed")
    gameSpeed = defaults.integer(forKey: "gameSpeed")
    setPiecesNode = defaults.object(forKey: "setPiecesNode") as! SKNode
  }
  
  override init() {
    super.init()
  }
  
  
  convenience init(viewFrame: CGRect) {
    self.init()
    
    var gameBoardWidth = (viewFrame.width) * screenWidthAmount
    
    columnWidth = (gameBoardWidth / numberOfBlocksWide).rounded()
    gameBoardWidth = gameBoardWidth - (gameBoardWidth.truncatingRemainder(dividingBy: columnWidth))
    
    let gameBoardXOffset = (viewFrame.width - gameBoardWidth) / 2
    
    let numberOfBlocksHigh = round((viewFrame.height * screenHieghtAmount) / columnWidth)
    
    let adjustedScreenHieghtAmount = columnWidth * numberOfBlocksHigh

    let gameBoardHieght = adjustedScreenHieghtAmount
    
    let gameBoardYOffset = (viewFrame.height) * ((1.0 - screenHieghtAmount) / 2)

    let borderPath = CGMutablePath()
    borderPath.move(to: CGPoint(x: gameBoardXOffset, y: gameBoardYOffset))
    borderPath.addLine(to: CGPoint(x: gameBoardXOffset, y: gameBoardYOffset + gameBoardHieght))
    borderPath.addLine(to: CGPoint(x: gameBoardXOffset + gameBoardWidth, y: gameBoardYOffset + gameBoardHieght))
    borderPath.addLine(to: CGPoint(x: gameBoardXOffset + gameBoardWidth, y: gameBoardYOffset))
    borderPath.closeSubpath()
    self.path = borderPath
    
    fillColor = .systemBackground
    
    let columns: [CGFloat] = Array(stride(from: gameBoardXOffset,
                                             to: self.frame.maxX,
                                             by: columnWidth))

    let rows: [CGFloat] = Array(stride(from: gameBoardYOffset,
                                        to: self.frame.maxY,
                                        by: columnWidth))

    let x = Array(stride(from: gameBoardXOffset + (columnWidth / 2),
                               to: self.frame.maxX - (columnWidth / 2),
                               by: columnWidth))

    xPositions = x.map { $0.rounded(.down) }
     
    let y = Array(stride(from: gameBoardYOffset + (columnWidth / 2),
                         to: self.frame.maxY +  (columnWidth * 1.5),
                               by: columnWidth))
    
    yPositions = y.map { $0.rounded(.down) }
    
    for xPos in columns {
      let line = GameBoardGraphLine(xPos: xPos, fromY: gameBoardYOffset, toY: self.frame.maxY)
      self.addChild(line)
    }
    
    for yPos in rows {
      let line = GameBoardGraphLine(yPos: yPos, fromX: gameBoardXOffset, toX: self.frame.maxX)
      self.addChild(line)
    }
    
    setPiecesNode.position = .zero
    self.addChild(setPiecesNode)
    
  }
  
  @objc
  func changeAppearance() {
    
  }
  
  
  func startGame() {
    addGamePiece()
    boardState = .inPlay
  }
  
  func resetGame() {
    boardState = .notInPlay
    if let parent = self.parent as? GameScene {
      parent.saveData()
    }
    activeGamePiece?.removeFromParent()
    activeGamePiece = nil
    occupiedPositions = [:]
    setPiecesNode.removeAllChildren()
    currentLevelSpeed = 40
  }
  
  func addGamePiece() {
    gameSpeed = currentLevelSpeed
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      guard self.boardState == .inPlay else { return }
      self.activeGamePiece = GamePieceGenerator.createGamePiece(type: .random(), size: self.columnWidth,
                                                                xPos: self.xPositions, yPos: self.yPositions)
      self.adjustXPositionIfOutOfBounds()
      self.addChild(self.activeGamePiece!)
    }
  }
  
  func adjustXPositionIfOutOfBounds() {
    for child in activeGamePiece!.children {
      var position = child.convert(.zero, to: self)
      if position.x.rounded(.up) < xPositions.first! || position.x.rounded(.up) > xPositions.last! {
        while position.x.rounded(.up) < xPositions.first! {
          activeGamePiece?.currentXPos += 1
          position = child.convert(.zero, to: self)
        }
        while position.x.rounded(.up) > xPositions.last! {
          activeGamePiece?.currentXPos -= 1
          position = child.convert(.zero, to: self)
        }
      }
    }
  }
  
  enum MoveDirection {
    case left, right, down, bottom
  }
  
  
  func movePiece(_ direciton: MoveDirection) {
    
    switch direciton {
    case .left:
      for child in activeGamePiece!.children {
        let node = child as! BaseNode
        let position = node.convert(.zero, to: self)
        if let currentXIndex = xPositions.firstIndex(of: position.x) {
          let nextXIndex = currentXIndex - 1
          if occupiedPositions[position.y] != nil &&
            occupiedPositions[position.y]!.contains(xPositions[nextXIndex]) {
            return
          }
        }
      }
      activeGamePiece?.currentXPos -= 1
      adjustXPositionIfOutOfBounds()
    case .right:
      for child in activeGamePiece!.children {
        let node = child as! BaseNode
        let position = node.convert(.zero, to: self)
        if let currentXIndex = xPositions.firstIndex(of: position.x) {
          let nextXIndex = currentXIndex + 1
          if occupiedPositions[position.y] != nil &&
            occupiedPositions[position.y]!.contains(xPositions[nextXIndex]) {
            return
          }
        }
      }
      activeGamePiece?.currentXPos += 1
      adjustXPositionIfOutOfBounds()
    case .down:
      checkNextYPositions()
    case .bottom:
      gameSpeed = 4
    }
  }
  
  
  private func checkNextYPositions() {
    
    guard activeGamePiece != nil else { return }
    
    var pieceIsSet = false

    for node in activeGamePiece!.children {
      
      let node = node as! BaseNode
      let position = node.convert(.zero, to: self)

      if position.y < yPositions.last! {
        node.colorNode()
      }
      //Check if the child nodes are at the bottom of the board
      if position.y <= yPositions.first! + 1 && pieceIsSet == false {
        recordLocations()
        transferChildNodes()
        checkForCompleteRows()
        addGamePiece()
        return
      }
      //Check the child node's next position
      else if let currentYIndex = yPositions.firstIndex(of: position.y) {
        guard currentYIndex > 0 else { continue }
        let nextYIndex = currentYIndex - 1
        if occupiedPositions[yPositions[nextYIndex]] != nil &&
           occupiedPositions[yPositions[nextYIndex]]!.contains(position.x) {
          pieceIsSet = true
        }
      }
      //Check for game over condition
      if position.y >= yPositions.last! && pieceIsSet {
        boardState = .gameOver
        if let parent = self.parent as? GameScene {
          parent.saveData()
          parent.gameOver()
        }
        return
      }
    }
    
    if pieceIsSet {
      recordLocations()
      transferChildNodes()
      checkForCompleteRows()
      addGamePiece()
      return
    }
    //Move piece down
    activeGamePiece!.currentYPos -= 1
  }
  
  
  func  transferChildNodes() {
    for child in activeGamePiece!.children {
      child.move(toParent: setPiecesNode)
      child.position.x = child.position.x.rounded(.up)
      child.position.y = child.position.y.rounded(.up)
    }
  }
  
  
  var numberOfRowsDeleted = 0
  var lastRowDeleted = 0
  
  private func checkForCompleteRows() {
 
    for row in occupiedPositions.keys {

      if occupiedPositions[row]!.count == xPositions.count {
        
        numberOfRowsDeleted += 1
        lastRowDeleted = yPositions.firstIndex(of: row)!
        for child in setPiecesNode.children {
          
          let position = child.convert(.zero, to: self)
          
          if position.y == row {
            let node = child as! BaseNode
            node.explode()
          }
        }
        occupiedPositions.removeValue(forKey: row)
      }
    }

    if numberOfRowsDeleted > 0 {
      
      if let parent = self.parent as? GameScene {
        var multiplier = 2
        for _ in 1...numberOfRowsDeleted {
          multiplier = multiplier * 2
        }
        parent.score = parent.score + (5 * multiplier)
        if parent.score % 100 == 0 {
          currentLevelSpeed -= 5
          parent.level += 1
        }
      }

      for each in occupiedPositions.keys.sorted() {

        if each > yPositions[lastRowDeleted] {
          //Move nodes down
          for child in setPiecesNode.children {
  
            if child.position.y == each {
              var index = self.yPositions.firstIndex(of: child.position.y)! - self.numberOfRowsDeleted
              if index < 0 { index = 0 }
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                child.position.y = self.yPositions[index]
              }
            }
          }
          //Move recorded occupied positions down
          let yIndexToMove = yPositions.firstIndex(of: each)!
          let moveToIndex = yIndexToMove - numberOfRowsDeleted
          occupiedPositions[yPositions[moveToIndex]] = occupiedPositions[yPositions[yIndexToMove]]
          occupiedPositions.removeValue(forKey: yPositions[yIndexToMove])
        }
      }
      
      numberOfRowsDeleted = 0
    }
  }
  
  
  func recordLocations() {
    
    guard activeGamePiece != nil else { return }
    
    for child in activeGamePiece!.children {
      
      let adjusted = child.convert(CGPoint(x: 0, y: 0), to: self)
      let pos = CGPoint(x: adjusted.x, y: adjusted.y)
      
      if occupiedPositions[pos.y] == nil {
        occupiedPositions[pos.y] = [pos.x]
      } else {
        occupiedPositions[pos.y]?.insert(pos.x)
      }
    }
  }
  
  
  func removeLastPositions() {
    
    for child in activeGamePiece!.children {
      let pos = child.convert(CGPoint(x: 0, y: 0), to: self)
      occupiedPositions[pos.y]?.remove(pos.x)
      if occupiedPositions[pos.y] == [] {
        occupiedPositions.removeValue(forKey: pos.y)
      }
    }
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

