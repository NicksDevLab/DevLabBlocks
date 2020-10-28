//
//  PlayerSelectVCPresentationDelegate.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/12/20.
//

import UIKit


final class PlayerSelectVCTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
   
  private let estimatedFinalHeight: CGFloat = UIScreen.main.bounds.height * 0.4
  private let animationDuration: TimeInterval = 0.3
  private lazy var animatorController = PlayerSelectVCAnimationController(estimatedFinalHeight: estimatedFinalHeight, animationDuration: animationDuration, isPresenting: true)
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animatorController.isPresenting = true
    return animatorController
  }
 
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    animatorController.isPresenting = false
    return animatorController
  }
  
}
