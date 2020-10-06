//
//  StartScreenButton.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit

class StartScreenButton: UIButton {
  
  init(title: String) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 5
    layer.borderColor = UIColor.systemGray.cgColor
    layer.borderWidth = 2
    
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
    titleLabel?.textAlignment = .center
    titleLabel?.numberOfLines = 0
    titleLabel?.lineBreakMode = .byWordWrapping
    
    setTitle(title, for: .normal)
    setTitleColor(.systemGray, for: .normal)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
