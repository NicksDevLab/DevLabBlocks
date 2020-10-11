//
//  ResetButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

class ResetButton: SKSpriteNode {
  
  var gameBoard: GameBoard?
  
  init(gameBoard: GameBoard) {
    self.gameBoard = gameBoard
    super.init(texture: SKTexture(imageNamed: "resetButton"), color: .white,
               size: CGSize(width: 50, height: 50))
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    gameBoard?.resetGame()
    if let parent = self.parent as? GameScene {
      parent.score = 0
      parent.level = 0
      parent.presentStartButton()
      parent.resetButton.removeFromParent()
      parent.pauseButton.removeFromParent()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
