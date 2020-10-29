//
//  SpriteButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/25/20.
//

import SpriteKit

final class SpriteButton: SKNode {
  
  private var path: CGPath!
  private var button: SKShapeNode!
  private var size: CGSize!
  
  var gameScene: GameScene!
  var text: String!
  var label: SKLabelNode!
  
  init(scene: GameScene, text: String) {
    self.gameScene = scene
    self.text = text
    super.init()
    self.isUserInteractionEnabled = true
    setupButton()
    setupLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupButton() {
    button = SKShapeNode(rectOf: CGSize(width: gameScene.view!.frame.width / 3, height: 50), cornerRadius: 10)
    button.lineWidth = 2
    button.strokeColor = .red
    button.fillColor = UIColor(named: "tetrisLabelBackground")!
    addChild(button)
  }
  
  private func setupLabel() {
    label = SKLabelNode()
    let attributes = [
      NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title2),
      NSAttributedString.Key.foregroundColor : UIColor(named: "tetrisGreen")!
    ]
    let labelString = NSAttributedString(string: text!, attributes: attributes)
    label.attributedText = labelString
    label.fontColor = UIColor(named: "tetrisYellow")
    label.position = CGPoint(x: 0, y: -(label.frame.width / 8))
    addChild(label)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if gameScene.gameBoard.boardState == .inPlay {
      gameScene.pauseGame()
    }
  }
  
}
