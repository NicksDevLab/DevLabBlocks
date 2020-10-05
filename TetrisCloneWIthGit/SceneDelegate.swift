//
//  SceneDelegate.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let navigationController = UINavigationController(rootViewController: StartScreenViewController())
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
  
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
  }


}

