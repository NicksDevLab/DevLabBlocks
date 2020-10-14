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
  var dismissGesture: UISwipeGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    setupTableView()
    setupAddNewPlayerButton()
    setupConstraints()
    setupDismissSwipeGesture()
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
  }
  
  private func setupAddNewPlayerButton() {
    addNewPlayerButton = StartScreenButton(title: NSLocalizedString("New Player", comment: "Add a new user"))
    addNewPlayerButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
    addNewPlayerButton.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
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
  
  private func setupDismissSwipeGesture() {
    dismissGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(_:)))
    dismissGesture.direction = .down
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(dismissGesture)
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



extension PlayerSelectViewController {
  
  @objc
  private func dismissView(_ sender: UISwipeGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc
  private func addPlayer() {
    let vc = AddPlayerViewController()
    present(vc, animated: true, completion: nil)
  }
}
