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
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    
    layer.cornerRadius = 5
    layer.borderColor = UIColor(named: "tetrisYellow")?.cgColor
    layer.borderWidth = 2
    layer.masksToBounds = true
    
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    titleLabel?.textAlignment = .center
    titleLabel?.numberOfLines = 0
    titleLabel?.lineBreakMode = .byWordWrapping
    
    setTitle(title, for: .normal)
    setTitleColor(UIColor(named: "tetrisGreen"), for: .normal)
  }
  
  init(image: UIImage) {
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    setImage(image, for: .normal)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
