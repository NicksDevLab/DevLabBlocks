//
//  SettingsViewController.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/11/20.
//

import UIKit
import CoreData


final class SettingsViewController: UIViewController {
  
  private var isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
  
  private var backButton: UIButton!
  private var backButtonWidthConstraint: NSLayoutConstraint!
  private var backButtonHeightConstraint: NSLayoutConstraint!
  
  private var tableView: UITableView!
  
  private var soundButton: UIButton!
  private var soundButtonWidthConstraint: NSLayoutConstraint!
  private var soundButtonHeightConstraint: NSLayoutConstraint!
  
  private var modeButton: UIButton!
  private var modeButtonWidthConstraint: NSLayoutConstraint!
  private var modeButtonHeightConstraint: NSLayoutConstraint!
  private var modeButtonTopConstraint: NSLayoutConstraint!
  
  private let spaceing: CGFloat = 12
  
  private var players: [Player] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    setupBackButton()
    setupTableView()
    setupSoundButton()
    setupModeButton()
    setupConstraints()
    retreiveCoreData()
  }
  
  
  private func setupBackButton() {
    backButton = UIButton()
    backButton.translatesAutoresizingMaskIntoConstraints = false
    backButton.backgroundColor = UIColor(named: "tetrisLabelBackground")
    backButton.setTitle("BACK", for: .normal)
    backButton.setTitleColor(.red, for: .normal)
    backButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    backButton.layer.cornerRadius = 10
    backButton.layer.borderWidth = 2
    backButton.layer.borderColor = UIColor(named: "tetrisMagenta")?.cgColor
    backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    
    backButtonWidthConstraint = backButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.45 : view.frame.width * 0.25)
    backButtonHeightConstraint = backButton.heightAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.21 : view.frame.width * 0.15)
    
    view.addSubview(backButton)
  }
  
  
  private func setupTableView() {
    
    tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.layer.cornerRadius = 10
    tableView.layer.borderWidth = 2
    tableView.layer.borderColor = UIColor(named: "tetrisGreen")?.cgColor
    
    tableView.register(SettingsViewPlayerTableViewCell.self, forCellReuseIdentifier: SettingsViewPlayerTableViewCell.reuseID)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    tableView.register(TetrisTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TetrisTableViewHeaderView.reuseID)
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    
    view.addSubview(tableView)
  }
  
  
  private func setupSoundButton() {
    
    soundButton = UIButton()
    soundButton.translatesAutoresizingMaskIntoConstraints = false
    soundButton.backgroundColor = UIColor(named: "tetrisLabelBackground")
    soundButton.setTitle("SOUND ON", for: .normal)
    soundButton.setTitleColor(.red, for: .normal)
    soundButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    soundButton.titleLabel?.numberOfLines = 0
    soundButton.titleLabel?.lineBreakMode = .byWordWrapping
    soundButton.titleLabel?.textAlignment = .center
    soundButton.layer.cornerRadius = 10
    soundButton.layer.borderWidth = 2
    soundButton.layer.borderColor = UIColor(named: "tetrisPurple")?.cgColor
    soundButton.addTarget(self, action: #selector(toggleSound(sender:)), for: .touchUpInside)
    soundButton.isSelected = UserDefaults.standard.bool(forKey: "isSoundOn")
    
    soundButtonWidthConstraint = soundButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width - (spaceing * 2) : view.frame.width * 0.4)
    soundButtonHeightConstraint = soundButton.heightAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.2 : view.frame.width * 0.4)
    
    view.addSubview(soundButton)
  }
  
  
  private func setupModeButton() {
    
    modeButton = UIButton()
    modeButton.translatesAutoresizingMaskIntoConstraints = false
    modeButton.backgroundColor = UIColor(named: "tetrisLabelBackground")
    modeButton.setTitle(isFontAccessible ? "DARK" : "DARK MODE", for: .normal)
    modeButton.setTitleColor(.red, for: .normal)
    modeButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    modeButton.titleLabel?.numberOfLines = 0
    modeButton.titleLabel?.lineBreakMode = .byWordWrapping
    modeButton.titleLabel?.textAlignment = .center
    modeButton.layer.cornerRadius = 10
    modeButton.layer.borderWidth = 2
    modeButton.layer.borderColor = UIColor(named: "tetrisPurple")?.cgColor
    modeButton.addTarget(self, action: #selector(toggleMode(sender:)), for: .touchUpInside)
    
    modeButtonWidthConstraint = modeButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width - spaceing : view.frame.width * 0.4)
    modeButtonHeightConstraint = modeButton.heightAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.2 : view.frame.width * 0.4)
    modeButtonTopConstraint = modeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: isFontAccessible ? (view.frame.width * 0.2) - (spaceing * 2) : spaceing)
    
    view.addSubview(modeButton)
  }
  
  // MARK: Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backButtonWidthConstraint,
      backButtonHeightConstraint,
      backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spaceing),
      backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spaceing),
      
      tableView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.52),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spaceing),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spaceing),
      tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      tableView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: spaceing),
      
      soundButtonWidthConstraint,
      soundButtonHeightConstraint,
      soundButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spaceing),
      soundButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: spaceing),
      
      modeButtonWidthConstraint,
      modeButtonHeightConstraint,
      modeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spaceing),
      modeButtonTopConstraint
    ])
  }
  
  // MARK: TraitCollection
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    
    backButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    backButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.45 : view.frame.width * 0.25
    backButtonHeightConstraint.constant = isFontAccessible ? view.frame.width * 0.21 : view.frame.width * 0.15
    
    soundButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    soundButtonWidthConstraint.constant = isFontAccessible ? view.frame.width - (spaceing * 2) : view.frame.width * 0.4
    soundButtonHeightConstraint.constant = isFontAccessible ? view.frame.width * 0.2 : view.frame.width * 0.4
    
    modeButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    modeButton.setTitle(isFontAccessible ? "DARK" : "DARK MODE", for: .normal)
    modeButtonWidthConstraint.constant =  isFontAccessible ? view.frame.width - (spaceing * 2) : view.frame.width * 0.4
    modeButtonHeightConstraint.constant = isFontAccessible ? view.frame.width * 0.2 : view.frame.width * 0.4
    modeButtonTopConstraint.constant = isFontAccessible ? (view.frame.height * 0.2) - (spaceing * 2) : spaceing
  }
}


// MARK: TableView Extension
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
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
}


// MARK: Methods Extension
extension SettingsViewController {
  
  private func retreiveCoreData() {
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
  
  private func deletePlayer(at index: Int) {
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
  
  @objc
  private func back() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc
  private func toggleSound(sender: UIButton) {
    if sender.isSelected {
      UserDefaults.standard.set(true, forKey: "isSoundOn")
    } else {
      UserDefaults.standard.set(false, forKey: "isSoundOn")
    }
  }
  
  @objc
  private func toggleMode(sender: UIButton) {
    
  }
}


