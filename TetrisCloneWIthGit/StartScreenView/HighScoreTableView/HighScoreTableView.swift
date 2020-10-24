//
//  HighScoreTableView.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/6/20.
//

import UIKit

class HighScoreTableView: UITableView {

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    translatesAutoresizingMaskIntoConstraints = false
    layer.masksToBounds = true
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor(named: "tetrisBlue")?.cgColor
    backgroundColor = .systemBackground
    
    register(HighScoreTableViewCell.self, forCellReuseIdentifier: HighScoreTableViewCell.reuseID)
    rowHeight = UITableView.automaticDimension
    estimatedRowHeight = UITableView.automaticDimension
    
    register(TetrisTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TetrisTableViewHeaderView.reuseID)
    sectionHeaderHeight = UITableView.automaticDimension
    estimatedSectionHeaderHeight = UITableView.automaticDimension
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
