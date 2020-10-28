//
//  HighScoreTableViewHeader.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit


final class TetrisTableViewHeaderView: UITableViewHeaderFooterView {
  
  static let reuseID = String(describing: self)
  
  var label: TetrisTableViewHeader!
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    label = TetrisTableViewHeader()
    addSubview(label)
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.topAnchor.constraint(equalTo: topAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


final class TetrisTableViewHeader: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    textColor = UIColor(named: "tetrisOrange")
    textAlignment = .center
    text = NSLocalizedString("HIGH SCORES", comment: "List of the highest scores achieved")
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}



