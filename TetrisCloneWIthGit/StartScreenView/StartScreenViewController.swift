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
    scoreTableView = UITableView(frame: .zero)
    scoreTableView.translatesAutoresizingMaskIntoConstraints = false
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    view.addSubview(scoreTableView)
  }
  
  private func setupButtons() {
    startButton = StartScreenButton(view: self.view, title: )
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    view.addSubview(startButton)
    
    settingsButton = StartScreenButton(view: self.view, title: "SETTINGS")
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    view.addSubview(settingsButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      scoreTableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      scoreTableView.heightAnchor.constraint(equalToConstant: 250),
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scoreTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75),
      
      startButton.widthAnchor.constraint(equalToConstant: 200),
      startButton.heightAnchor.constraint(equalToConstant: 50),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
      
      settingsButton.widthAnchor.constraint(equalToConstant: 200),
      settingsButton.heightAnchor.constraint(equalToConstant: 50),
      settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      settingsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160)
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
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "HIGH SCORES"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewCells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")!
    cell.textLabel?.text = tableViewCells[indexPath.row]
    cell.backgroundColor = .green
    return cell
  }
  
}
