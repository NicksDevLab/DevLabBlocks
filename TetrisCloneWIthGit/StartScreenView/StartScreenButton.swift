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
    self.setTitle(title, for: .normal)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .white
    self.layer.cornerRadius = 5
    self.setTitleColor(.blue, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
