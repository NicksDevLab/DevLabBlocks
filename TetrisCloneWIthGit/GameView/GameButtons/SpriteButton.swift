//
//  SpriteButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/25/20.
//

import SpriteKit

class SpriteButton: SKNode {
  
  private var path: CGPath!
  private var button: SKShapeNode!
  private var size: CGSize!
  
  var text: String!
  
  var view: SKView!
  
  var label: SKLabelNode!
  
  init(view: SKView, text: String) {
    self.view = view
    self.text = text
    super.init()
    setupButton()
    setupLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupButton() {
    button = SKShapeNode(rectOf: CGSize(width: 120, height: 50), cornerRadius: 10)
    button.lineWidth = 2
    button.strokeColor = .red
    button.fillColor = UIColor(named: "tetrisLabelBackground")!
    addChild(button)
  }
  
  private func setupLabel() {
    label = SKLabelNode(text: text)
    label.position.y = -15
    label.fontColor = UIColor(named: "tetrisYellow")
    addChild(label)
  }
  
}
