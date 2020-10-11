//
//  GameViewController.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
  
  var gameScene: GameScene!
  
  override func loadView() {
    super.loadView()
    self.navigationController?.isNavigationBarHidden = true
    view = SKView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    if let skView = self.view as! SKView? {

      skView.ignoresSiblingOrder = true
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.showsPhysics = true
      
      gameScene = GameScene(size: skView.frame.size)
      gameScene.scaleMode = .aspectFill

      skView.presentScene(gameScene)
    }
  }
  
  
  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }
}
