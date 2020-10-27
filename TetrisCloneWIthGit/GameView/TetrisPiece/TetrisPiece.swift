//
//  TetrisPiece.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

protocol TetrisPieceProtocol {
  
  var blockOne: BaseNode! { get }
  var blockTwo: BaseNode! { get }
  var blockThree: BaseNode! { get }
  var blockFour: BaseNode! { get }
  
  var currentOrientation: Orientation { get set }
  var nextOrientation: Int { get set }
  
  func stackNodes()
  func rotate()
}

enum Orientation: Int {
  case left = 0, down, right, up
}

class TetrisPiece: SKNode {
  
  var size: CGFloat!
  
  var xPos: [CGFloat] = []
  var yPos: [CGFloat] = []
  
  var currentXPos = 0 {
    willSet(newValue) {
      guard newValue >= 0 && newValue < xPos.count else { return }
      self.position.x = self.xPos[newValue]
    }
  }
  
  var currentYPos = 0 {
    willSet(newValue) {
      guard newValue >= 0 && newValue < yPos.count else { return }
      self.position.y = self.yPos[newValue]
    }
  }
  
  init(size: CGFloat, xPos: [CGFloat], yPos: [CGFloat]) {
    self.size = size
    self.xPos = xPos
    self.yPos = yPos
    super.init()
    self.position.x = xPos.randomElement() ?? 0
    self.position.y = yPos.last ?? 0
    self.currentXPos = xPos.firstIndex(of: self.position.x) ?? 0
    self.currentYPos = yPos.count - 1
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func rotate() {

  }
  
}
