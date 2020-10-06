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
  
  var tableViewCells = ["ONE", "TWO", "THREE", "FOUR", "FIVE"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    
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
    view.addSubview(gameTitleLabel)
    gameTitleLabel.sizeToFit()
  }
  
  private func setupTableView() {
    scoreTableView = HighScoreTableView(frame: .zero)
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    view.addSubview(scoreTableView)
    scoreTableView.sizeToFit()
  }
  
  private func setupButtons() {
    startButton = StartScreenButton(title: NSLocalizedString("START THE GAME", comment: "Start/Begin the game"))
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    view.addSubview(startButton)
    startButton.sizeToFit()
    
    settingsButton = StartScreenButton(title: NSLocalizedString("SETTINGS", comment: "Application Settings"))
    settingsButton.titleLabel?.lineBreakMode = .byCharWrapping
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    view.addSubview(settingsButton)
    settingsButton.sizeToFit()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      gameTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.3),

      scoreTableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      scoreTableView.heightAnchor.constraint(equalToConstant: 200),
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scoreTableView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 50),

      startButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.topAnchor.constraint(equalTo: scoreTableView.bottomAnchor, constant: 50),

      settingsButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5),
      settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      settingsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 25)
    ])
  }
  
  @objc
  func goToGameViewController() {
    fireHapticFeedback()
  }
  
  @objc
  func goToSettingsViewController() {
    fireHapticFeedback()
  }
  
  func fireHapticFeedback() {
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    feedback.impactOccurred()
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
    header.sizeToFit()
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
