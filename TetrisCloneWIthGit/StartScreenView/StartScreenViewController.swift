//
//  StartScreenViewController.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit



class StartScreenViewController: UIViewController {
  
  var gameTitleLabel: UILabel!
  var scoreTableView: UITableView!
  var startButton: StartScreenButton!
  var settingsButton: StartScreenButton!
  
  var tableViewCells = [""]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemFill
    setupLabel()
    setupTableView()
    setupButtons()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
  }
  
  private func setupLabel() {
    gameTitleLabel = GameTitleLabel(view: self.view)
  }
  
  private func setupTableView() {
    scoreTableView = HighScoreTableView(frame: .zero)
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    view.addSubview(scoreTableView)
  }
  
  private func setupButtons() {
    startButton = StartScreenButton(view: self.view, title: NSLocalizedString("START THE GAME", comment: "Start/Begin the game"))
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    view.addSubview(startButton)
    
    settingsButton = StartScreenButton(view: self.view, title: NSLocalizedString("SETTINGS", comment: "Application Settings"))
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    view.addSubview(settingsButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      gameTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      gameTitleLabel.heightAnchor.constraint(equalToConstant: view.frame.width * 0.2),
      gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.3),
      
      scoreTableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      scoreTableView.heightAnchor.constraint(equalToConstant: 250),
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scoreTableView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 50),
      
      startButton.widthAnchor.constraint(equalToConstant: 200),
      startButton.heightAnchor.constraint(equalToConstant: 50),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.topAnchor.constraint(equalTo: scoreTableView.bottomAnchor, constant: 50),
      
      settingsButton.widthAnchor.constraint(equalToConstant: 200),
      settingsButton.heightAnchor.constraint(equalToConstant: 50),
      settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      settingsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 25)
    ])
  }
  
  @objc
  func goToGameViewController() {
    print("START GAME")
  }
  
  @objc
  func goToSettingsViewController() {
  }
}


extension StartScreenViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HighScoreTableViewHeader.reuseID) as! HighScoreTableViewHeader
    return header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewCells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.reuseID)!
    cell.textLabel?.text = tableViewCells[indexPath.row]
    return cell
  }
  
}
