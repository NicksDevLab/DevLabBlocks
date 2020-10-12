//
//  PlayerSelectVCAnimation.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/12/20.
//

import UIKit



enum ViewControllerScale {
  case modelPresentationScale
  case reset
  var transform: CATransform3D {
    switch self {
    case .modelPresentationScale:
        return CATransform3DMakeScale(0.88, 0.88, 1)
    case .reset:
        return CATransform3DMakeScale(1, 1, 1)
     }
  }
}


class PlayerSelectVCAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  let estimatedFinalHeight: CGFloat
  let animationDuration: TimeInterval
  var isPresenting: Bool

  init(estimatedFinalHeight: CGFloat, animationDuration: TimeInterval, isPresenting: Bool) {
    print("HELLO AnimateTransition")
    self.estimatedFinalHeight = estimatedFinalHeight
    self.animationDuration = animationDuration
    self.isPresenting = isPresenting
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return animationDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    guard let fromVC = transitionContext.viewController(forKey: .from),
    let toVC = transitionContext.viewController(forKey: .to) else { return }

    let containerView = transitionContext.containerView

    fromVC.beginAppearanceTransition(false, animated: true)
    toVC.beginAppearanceTransition(true, animated: true)

    if isPresenting {

    toVC.view.frame.origin.y = fromVC.view.frame.maxY
    containerView.addSubview(toVC.view)
    UIView.animate(withDuration: animationDuration, animations: {
      toVC.view.frame.origin.y = self.estimatedFinalHeight
      fromVC.view.layer.transform = ViewControllerScale.modelPresentationScale.transform
    }, completion: { _ in
      fromVC.endAppearanceTransition()
      toVC.endAppearanceTransition()
      fromVC.view.layer.cornerRadius = 15
      toVC.view.layer.cornerRadius = 15
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    } else {
    containerView.addSubview(fromVC.view)
    UIView.animate(withDuration: animationDuration, animations: {
      fromVC.view.frame.origin.y = UIScreen.main.bounds.maxY
      toVC.view.layer.transform = ViewControllerScale.reset.transform
    }, completion: { _ in
      fromVC.endAppearanceTransition()
      toVC.endAppearanceTransition()
      fromVC.view.layer.cornerRadius = 0
      toVC.view.layer.cornerRadius = 0
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    }
  }
  
}
