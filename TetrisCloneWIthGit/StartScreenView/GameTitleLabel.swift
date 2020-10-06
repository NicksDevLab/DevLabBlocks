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
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
    text = NSLocalizedString("STACK BLOCKS", comment: "Name of the App")
    textAlignment = .center
    textColor = .white
    backgroundColor = .blue
    view.addSubview(self)
    
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      self.heightAnchor.constraint(equalToConstant: view.frame.width * 0.2),
      self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.3)
    ])
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
