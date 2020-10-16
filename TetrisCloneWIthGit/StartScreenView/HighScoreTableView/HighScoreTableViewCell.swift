//
//  HighScoreTableViewCell.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
  
  static let reuseID = "HighScoreTableViewCell"
  
  var nameLabel: UILabel!
  var scoreLabel: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    
    setupNameLabel()
    setupScoreLabel()
    setupConstraints()
  }
  
  private func setupNameLabel() {
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
    contentView.addSubview(nameLabel)
  }
  
  private func setupScoreLabel() {
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.font = UIFont.preferredFont(forTextStyle: .body)
    contentView.addSubview(scoreLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
      
      scoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      scoreLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
