//
//  PlayerSelectView.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit


class PlayerSelectViewController: UIViewController {
  
  let tableView = HighScoreTableView()
  var addNewPlayerButton: StartScreenButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green

    setupTableView()
    setupAddNewPlayerButton()
    setupConstraints()
    
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
  }
  
  private func setupAddNewPlayerButton() {
    addNewPlayerButton = StartScreenButton(title: NSLocalizedString("New Player", comment: "Add a new user"))
    addNewPlayerButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
    view.addSubview(addNewPlayerButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
      tableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.4),
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05),
      
      addNewPlayerButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6),
      addNewPlayerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      addNewPlayerButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: view.frame.height * 0.03)
    ])
  }
}


extension PlayerSelectViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = HighScoreTableViewHeader()
    view.text = NSLocalizedString("Select Player", comment: "List of the highest scores achieved")
    return view
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.reuseID) as! HighScoreTableViewCell
    cell.textLabel?.text = String(describing: indexPath.row)
    return cell
  }
  
  
}
