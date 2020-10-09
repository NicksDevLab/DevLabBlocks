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
  
  var gameLabelWidthConstraint: NSLayoutConstraint!
  var scoreTableViewWidthConstraint: NSLayoutConstraint!
  var startButtonWidthConstraint: NSLayoutConstraint!
  var settingsButtonWidthConstraint: NSLayoutConstraint!
  
  var tableViewCells = ["ONE", "TWO", "THREE", "FOUR", "FIVE"]
  
  var isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory 
  
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
    gameLabelWidthConstraint = gameTitleLabel.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    gameTitleLabel.sizeToFit()
  }
  
  private func setupTableView() {
    scoreTableView = HighScoreTableView(frame: .zero)
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    scoreTableViewWidthConstraint = scoreTableView.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    view.addSubview(scoreTableView)
    scoreTableView.sizeToFit()
  }
  
  private func setupButtons() {
    startButton = StartScreenButton(title: NSLocalizedString("START THE GAME", comment: "Start/Begin the game"))
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    startButtonWidthConstraint = startButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    view.addSubview(startButton)
    startButton.sizeToFit()
    
    settingsButton = StartScreenButton(title: NSLocalizedString("SETTINGS", comment: "Application Settings"))
    settingsButton.titleLabel?.lineBreakMode = .byCharWrapping
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    settingsButtonWidthConstraint = settingsButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5)
    view.addSubview(settingsButton)
    settingsButton.sizeToFit()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      gameLabelWidthConstraint,
      gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height * 0.3),

      scoreTableViewWidthConstraint,
      scoreTableView.heightAnchor.constraint(equalToConstant: 200),
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scoreTableView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 50),

      startButtonWidthConstraint,
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.topAnchor.constraint(equalTo: scoreTableView.bottomAnchor, constant: 50),

      settingsButtonWidthConstraint,
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
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    
    gameLabelWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    scoreTableViewWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    startButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    settingsButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5
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
    let label = HighScoreTableViewHeader()
    return label
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
