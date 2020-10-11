//
//  Extensions.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import CoreGraphics
import UIKit



extension UIView {
  func addGestureRecognizers(_ gestures: UIGestureRecognizer...) {
    for gesture in gestures {
      self.addGestureRecognizer(gesture)
    }
  }
}


extension CGFloat {
  func deg2rad() -> CGFloat {
      return self * .pi / 180
  }
}
