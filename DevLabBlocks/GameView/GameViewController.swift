//
//  GameViewController.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/11/20.
//

import UIKit
import SpriteKit
import GameplayKit

final class GameViewController: UIViewController {
  
  private var gameScene: GameScene!
  
  override func loadView() {
    super.loadView()
    self.navigationController?.isNavigationBarHidden = true
    view = SKView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSKView()
  }
  
  private func setupSKView() {
    if let skView = self.view as! SKView? {

      skView.ignoresSiblingOrder = true
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.showsPhysics = true
      gameScene = GameScene(size: skView.frame.size)
      gameScene.scaleMode = .fill

      skView.presentScene(gameScene)
    }
  }
  
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if previousTraitCollection?.hasDifferentColorAppearance(comparedTo: .current) != nil {
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
