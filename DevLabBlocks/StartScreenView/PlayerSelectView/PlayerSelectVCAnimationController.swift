//
//  PlayerSelectVCAnimation.swift
//  DevLabBlocks
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


final class PlayerSelectVCAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let estimatedFinalHeight: CGFloat
  private let animationDuration: TimeInterval
  
  var isPresenting: Bool

  init(estimatedFinalHeight: CGFloat, animationDuration: TimeInterval, isPresenting: Bool) {
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
    
    let shadeView = UIView(frame: fromVC.view.frame)
    shadeView.backgroundColor = .black
    shadeView.alpha = 0.0
    
    if isPresenting {
    containerView.addSubview(shadeView)
    toVC.view.frame.origin.y = fromVC.view.frame.maxY
    containerView.addSubview(toVC.view)
    UIView.animate(withDuration: animationDuration, animations: {
      toVC.view.frame.origin.y = self.estimatedFinalHeight
      fromVC.view.layer.transform = ViewControllerScale.modelPresentationScale.transform
      shadeView.alpha = 0.5
      fromVC.view.layer.cornerRadius = 15
      toVC.view.layer.cornerRadius = 15
    }, completion: { _ in
      fromVC.endAppearanceTransition()
      toVC.endAppearanceTransition()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    } else {
    containerView.addSubview(fromVC.view)
    UIView.animate(withDuration: animationDuration, animations: {
      fromVC.view.frame.origin.y = UIScreen.main.bounds.maxY
      toVC.view.layer.transform = ViewControllerScale.reset.transform
      shadeView.alpha = 0.0
      fromVC.view.layer.cornerRadius = 0
      toVC.view.layer.cornerRadius = 0
    }, completion: { _ in
      shadeView.removeFromSuperview()
      fromVC.endAppearanceTransition()
      toVC.endAppearanceTransition()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
    }
  }
  
}
