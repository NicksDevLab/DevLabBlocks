//
//  SettingsViewController.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import UIKit
import CoreData


class SettingsViewController: UIViewController {
  
  var tableView: UITableView!
  var players: [Player] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    retreiveCoreData()
  }
  
  private func setupTableView() {
    tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.layer.cornerRadius = 12
    
    tableView.register(SettingsViewPlayerTableViewCell.self, forCellReuseIdentifier: SettingsViewPlayerTableViewCell.reuseID)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    tableView.register(TetrisTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TetrisTableViewHeaderView.reuseID)
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    
    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7),
      tableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9),
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
    
  override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
  }

}



extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TetrisTableViewHeaderView.reuseID) as! TetrisTableViewHeaderView
    cell.label.text = "Remove Players"
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewPlayerTableViewCell.reuseID) as! SettingsViewPlayerTableViewCell
    cell.nameLabel.text = players[indexPath.row].name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deletePlayer(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
}



extension SettingsViewController {
  
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
  
  func deletePlayer(at index: Int) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let player = players[index]
    context.delete(player)
    players.remove(at: index)
    do {
      try context.save()
    } catch {
      print(error)
    }
  }
}
