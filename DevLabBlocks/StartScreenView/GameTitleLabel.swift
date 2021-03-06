//
//  GameTitleLabel.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit

final class GameTitleLabel: UILabel {

  init(view: UIView) {
    super.init(frame: view.frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor(named: "tetrisLabelBackground")
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
    numberOfLines = 0
    lineBreakMode = .byWordWrapping
    textAlignment = .center
    textColor = UIColor(named: "tetrisRed")
    text = NSLocalizedString("STACK BLOCKS", comment: "Name of the App")

    layer.masksToBounds = true
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor(named: "tetrisBlue")?.cgColor
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    font = UIFont.preferredFont(forTextStyle: .largeTitle)
  }
  
}
