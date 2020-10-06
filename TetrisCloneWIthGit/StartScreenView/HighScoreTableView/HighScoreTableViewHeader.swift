//
//  HighScoreTableViewHeader.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableViewHeader: UITableViewHeaderFooterView {
  
  static let reuseID = "HighScoreHeader"

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier) 
    textLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
    textLabel?.numberOfLines = 0
    textLabel?.lineBreakMode = .byWordWrapping
    textLabel?.textColor = .systemGray
    textLabel?.text = NSLocalizedString("HIGH SCORES", comment: "List of the highest scores achieved")
    textLabel?.textAlignment = .center
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    textLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
