//
//  PauseButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit

class PauseButton: SKSpriteNode {
  
  var gameBoard: GameBoard?
  var isSelected = false
  
  init(gameBoard: GameBoard) {
    self.gameBoard = gameBoard
    super.init(texture: SKTexture(imageNamed: "pauseButton"), color: .white,
               size: CGSize(width: 50, height: 50))
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isSelected == false {
      gameBoard?.boardState = .paused
      self.texture = SKTexture(imageNamed: "playButton")
      isSelected = true
    } else {
      gameBoard?.boardState = .inPlay
      self.texture = SKTexture(imageNamed: "pauseButton")
      isSelected = false
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
