//
//  HighScoreTableViewCell.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
  
  static let reuseID = "HighScoreTableViewCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
