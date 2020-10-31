//
//  GameBoardGraphLine.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit


final class GameBoardGraphLine: SKShapeNode {
  
  private let pos: CGFloat
  private let from: CGFloat
  private let to: CGFloat
  
  init(xPos: CGFloat, fromY: CGFloat, toY: CGFloat) {
    self.pos = xPos
    self.from = fromY
    self.to = toY
    super.init()
    drawXLines()
  }
  
  init(yPos: CGFloat, fromX: CGFloat, toX: CGFloat) {
    self.pos = yPos
    self.from = fromX
    self.to = toX
    super.init()
    drawYLines()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func drawXLines() {
    let line = CGMutablePath()
    line.move(to: CGPoint(x: pos, y: from))
    line.addLine(to: CGPoint(x: pos, y: to))
    self.path = line
    self.strokeColor = .lightGray
  }
  
  
  private func drawYLines() {
    let line = CGMutablePath()
    line.move(to: CGPoint(x: from, y: pos))
    line.addLine(to: CGPoint(x: to, y: pos))
    self.path = line
    self.strokeColor = .lightGray
  }
  
}

