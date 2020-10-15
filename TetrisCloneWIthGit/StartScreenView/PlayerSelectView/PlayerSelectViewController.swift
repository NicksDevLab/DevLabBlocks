//
//  PlayerSelectView.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit
import CoreData

class PlayerSelectViewController: UIViewController {
  
  let tableView = HighScoreTableView()
  var addNewPlayerButton: StartScreenButton!
  var dismissGesture: UISwipeGestureRecognizer!
  
  var isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
  
  var tableViewHeightConstraint: NSLayoutConstraint!
  var newPlayerButtonHeightConstraint: NSLayoutConstraint!
  
  var thisParent: StartScreenViewController!
  
  var players: [Player] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    setupTableView()
    setupAddNewPlayerButton()
    setupConstraints()
    setupDismissSwipeGesture()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    retreiveCoreData()
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.height * 0.35 : view.frame.height * 0.4)
    view.addSubview(tableView)
  }
  
  private func setupAddNewPlayerButton() {
    addNewPlayerButton = StartScreenButton(title: NSLocalizedString("New Player", comment: "Add a new user"))
    addNewPlayerButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
    addNewPlayerButton.addTarget(self, action: #selector(addPlayer), for: .touchUpInside)
    newPlayerButtonHeightConstraint = addNewPlayerButton.heightAnchor.constraint(equalToConstant: isFontAccessible ? 50 : 100)
    view.addSubview(addNewPlayerButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
      tableViewHeightConstraint,
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05),
      
      addNewPlayerButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6),
      newPlayerButtonHeightConstraint,
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
  
  // MARK: traitCollectionDidChange
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    tableViewHeightConstraint.constant = isFontAccessible ? view.frame.height * 0.35 : view.frame.height * 0.4
    newPlayerButtonHeightConstraint.constant = isFontAccessible ? 110 : 50
  }
}



// MARK: TableViewDelegate Extension
extension PlayerSelectViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if isFontAccessible {
      return 60
    } else {
      return 30
    }
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 45
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = HighScoreTableViewHeader()
    view.text = NSLocalizedString("Select Player", comment: "List of the highest scores achieved")
    return view
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.reuseID) as! HighScoreTableViewCell
    cell.textLabel?.text = players[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    (UIApplication.shared.delegate as! AppDelegate).defaults.set(players[indexPath.row].name, forKey: "currentPlayer")
    dismiss(animated: true) {
      let gameVC = GameViewController()
      self.thisParent.navigationController!.pushViewController(gameVC, animated: true)
    }
  }
}


// MARK: Methods Extension
extension PlayerSelectViewController {
  
  @objc
  private func dismissView(_ sender: UISwipeGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
  
  @objc
  private func addPlayer() {
    let vc = AddPlayerViewController()
    vc.thisParent = self
    present(vc, animated: true, completion: nil)
  }
  
  func retreiveCoreData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let playerFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    playerFetchRequest.sortDescriptors = [
      NSSortDescriptor(key: "lastPlayed", ascending: false)
    ]
    do {
      players = try context.fetch(playerFetchRequest) as! [Player]
      tableView.reloadData()
    }
    catch {
      print(error)
    }
  }
}
