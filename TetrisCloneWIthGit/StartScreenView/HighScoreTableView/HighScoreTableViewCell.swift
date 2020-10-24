//
//  HighScoreTableViewCell.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
  
  static let reuseID = "HighScoreTableViewCell"
  
  var isAccessibleSize = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
  
  var stackView: UIStackView!
  var nameLabel: UILabel!
  var scoreLabel: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    
    setupNameLabel()
    setupScoreLabel()
    setupStackView()
  }
  
  private func setupStackView() {
    stackView = UIStackView(arrangedSubviews: [nameLabel, scoreLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = isAccessibleSize ? .vertical : .horizontal
    contentView.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  private func setupNameLabel() {
    nameLabel = UILabel()
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    nameLabel.textAlignment = isAccessibleSize ? .center : .left
  }
  
  private func setupScoreLabel() {
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    scoreLabel.textAlignment = isAccessibleSize ? .center : .right
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    isAccessibleSize = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    stackView.axis = isAccessibleSize ? .vertical : .horizontal
    nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    nameLabel.textAlignment = isAccessibleSize ? .center : .left
    scoreLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    scoreLabel.textAlignment = isAccessibleSize ? .center : .right
    stackView.distribution = isAccessibleSize ? .equalCentering : .equalSpacing
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
