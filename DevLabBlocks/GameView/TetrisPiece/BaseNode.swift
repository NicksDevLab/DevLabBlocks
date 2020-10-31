//
//  BaseNode.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

class BaseNode: SKShapeNode {
  
  var ok = false
  
  static var colors: Set<UIColor> = [.blue, .cyan, .green, .orange, .purple, .red, .yellow]
  
  let size: CGFloat!
  var color: UIColor!
  
  init(size: CGFloat, color: UIColor) {
    self.size = size
    self.color = color
    super.init()
    
    let pathToDraw = CGMutablePath()
    pathToDraw.move(to: CGPoint(x: -(size / 2), y: -(size / 2)))
    pathToDraw.addLine(to: CGPoint(x: -(size / 2), y: (size / 2)))
    pathToDraw.addLine(to: CGPoint(x: (size / 2), y: (size / 2)))
    pathToDraw.addLine(to: CGPoint(x: (size / 2), y: -(size / 2)))
    pathToDraw.closeSubpath()
    
    self.path = pathToDraw
    
    self.name = "baseNode"
  }
  
  func colorNode() {
    // TODO: create a shader to use as a fill
    self.strokeColor = .gray
    self.fillColor = self.color
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func explode() {
    let sparkEmmiter = SKEmitterNode(fileNamed: "Explode")!
    self.addChild(sparkEmmiter)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
      self.removeFromParent()
    }
  }
  
}

