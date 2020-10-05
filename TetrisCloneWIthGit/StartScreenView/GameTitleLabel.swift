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
    self.translatesAutoresizingMaskIntoConstraints = false
    self.text = "STACK BLOCKS"
    self.textAlignment = .center
    self.textColor = .white
    self.backgroundColor = .blue
    view.addSubview(self)
    
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      self.heightAnchor.constraint(equalToConstant: view.frame.width * 0.2),
      self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.3)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
