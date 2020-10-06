//
//  StartScreenButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit

class StartScreenButton: UIButton {

  var view: UIView
  
  init(view: UIView, title: String) {
    self.view = view
    super.init(frame: .zero)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    setTitle(title, for: .normal)
    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 5
    setTitleColor(.secondarySystemBackground, for: .normal)
    layer.borderColor = UIColor.secondarySystemBackground.cgColor
    layer.borderWidth = 2
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
