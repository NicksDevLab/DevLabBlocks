//
//  SceneDelegate.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController!
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    navigationController = UINavigationController(rootViewController: StartScreenViewController())
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
//    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    
  }

  func sceneWillResignActive(_ scene: UIScene) {
    
  }

}

