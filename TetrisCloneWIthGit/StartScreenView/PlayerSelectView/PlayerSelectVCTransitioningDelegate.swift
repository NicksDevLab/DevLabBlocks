//
//  PlayerSelectVCPresentationDelegate.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/12/20.
//

import UIKit


class PlayerSelectVCTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
   
  private let estimatedFinalHeight: CGFloat = UIScreen.main.bounds.height * 0.4
  private let animationDuration: TimeInterval = 0.3
  private lazy var animatorController = PlayerSelectVCAnimationController(estimatedFinalHeight: estimatedFinalHeight, animationDuration: animationDuration, isPresenting: true)
  
  override init() {
    super.init()
    print("delegate init")
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController)
  -> UIViewControllerAnimatedTransitioning? {
    animatorController.isPresenting = true
    print("animationController presented")
    return animatorController
  }
 
  func animationController(forDismissed dismissed: UIViewController)
  -> UIViewControllerAnimatedTransitioning? {
    animatorController.isPresenting = false
    print("animationController dismissed")
    return animatorController
  }
  
}
