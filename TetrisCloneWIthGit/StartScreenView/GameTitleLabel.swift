//
//  GameTitleLabel.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit

class GameTitleLabel: UILabel {

  init(view: UIView) {
    super.init(frame: view.frame)
    translatesAutoresizingMaskIntoConstraints = false
    layer.masksToBounds = true
    layer.cornerRadius = 10
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
    text = NSLocalizedString("STACK BLOCKS", comment: "Name of the App")
    textAlignment = .center
    textColor = .secondarySystemBackground
    layer.borderWidth = 2
    layer.borderColor = UIColor.secondarySystemBackground.cgColor
    view.addSubview(self)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
