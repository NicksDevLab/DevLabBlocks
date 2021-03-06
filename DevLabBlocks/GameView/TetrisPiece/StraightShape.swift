//
//  StraightShape.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

final class StraightShape: TetrisPiece, TetrisPieceProtocol {
  
  internal var blockOne: BaseNode!
  internal var blockTwo: BaseNode!
  internal var blockThree: BaseNode!
  internal var blockFour: BaseNode!
  
  private var color = BaseNode.colors.randomElement()!
  
  internal var currentOrientation: Orientation = .left
  internal var nextOrientation = 1

  override init(size: CGFloat, xPos: [CGFloat], yPos: [CGFloat]) {
    super.init(size: size, xPos: xPos, yPos: yPos)
    stackNodes()
  }
  
  init(size: CGFloat) {
    super.init(size: size, xPos: [], yPos: [])
    stackNodes()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  internal func stackNodes() {
    blockOne = BaseNode(size: self.size, color: self.color)
    blockOne.position = .zero
    self.addChild(blockOne)
    blockTwo = BaseNode(size: self.size, color: self.color)
    blockTwo.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y - size)
    self.addChild(blockTwo)
    blockThree = BaseNode(size: self.size, color: self.color)
    blockThree.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y + size)
    self.addChild(blockThree)
    blockFour = BaseNode(size: self.size, color: self.color)
    blockFour.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y + (size * 2))
    self.addChild(blockFour)
  }
  
  override func rotate() {
     
     currentOrientation = Orientation(rawValue: nextOrientation)!
     
     switch currentOrientation {
     case .left, .right:
      blockTwo.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y - size)
       blockThree.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y + size)
       blockFour.position = CGPoint(x: blockOne.position.x, y: blockOne.position.y + (size * 2))
     case .down, .up:
       blockTwo.position = CGPoint(x: blockOne.position.x + size, y: blockOne.position.y)
       blockThree.position = CGPoint(x: blockOne.position.x - size, y: blockOne.position.y)
       blockFour.position = CGPoint(x: blockOne.position.x - (size * 2), y: blockOne.position.y)
     }
     
     if nextOrientation == 3 {
       nextOrientation = 0
     } else {
       nextOrientation += 1
     }
  }
}
