//
//  SquareShape.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

class SquareShape: TetrisPiece, TetrisPieceProtocol {
  
  var blockOne: BaseNode!
  var blockTwo: BaseNode!
  var blockThree: BaseNode!
  var blockFour: BaseNode!
  
  var color: UIColor!
  
  var currentOrientation: Orientation = .left
  var nextOrientation = 0
  
  override init(size: CGFloat, xPos: [CGFloat], yPos: [CGFloat]) {
    super.init(size: size, xPos: xPos, yPos: yPos)
    self.color = BaseNode.colors.randomElement()
    stackNodes()
  }
  
  convenience init(size: CGFloat) {
    self.init(size: size, xPos: [], yPos: [])
    stackNodes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func stackNodes() {
    blockOne = BaseNode(size: self.size, color: self.color)
    blockOne.position = .zero
    self.addChild(blockOne)
    blockTwo = BaseNode(size: self.size, color: self.color)
    blockTwo.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y + size)
    self.addChild(blockTwo)
    blockThree = BaseNode(size: self.size, color: self.color)
    blockThree.position = CGPoint(x: blockOne.position.x + size, y: blockOne.position.y)
    self.addChild(blockThree)
    blockFour = BaseNode(size: self.size, color: self.color)
    blockFour.position = CGPoint(x: blockOne.position.x + size, y: blockOne.position.y + size)
    self.addChild(blockFour)
  }
  
  override func rotate() {
    
    currentOrientation = Orientation(rawValue: nextOrientation)!
    
    switch currentOrientation {
    case .left:
      print()
    case .down:
      print()
    case .right:
      print()
    case .up:
      print()
    }
    
    if nextOrientation == 3 {
      nextOrientation = 0
    } else {
      nextOrientation += 1
    }
  }
}

