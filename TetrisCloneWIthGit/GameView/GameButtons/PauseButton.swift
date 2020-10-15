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
    super.init(texture: nil, color: UIColor.systemYellow, size: CGSize(width: 45, height: 45))
    isUserInteractionEnabled = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isSelected == false {
      gameBoard?.boardState = .paused
      isSelected = true
    } else {
      gameBoard?.boardState = .inPlay
      isSelected = false
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
