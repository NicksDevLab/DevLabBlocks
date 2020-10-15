//
//  HighScoreTableViewHeader.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableViewHeader: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    font = UIFont.preferredFont(forTextStyle: .subheadline)
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    textColor = UIColor(named: "tetrisOrange")
    textAlignment = .center
    text = NSLocalizedString("HIGH SCORES", comment: "List of the highest scores achieved")
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
