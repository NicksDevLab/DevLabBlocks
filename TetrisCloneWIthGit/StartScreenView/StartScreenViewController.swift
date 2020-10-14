//
//  StartScreenViewController.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit
import CoreData


class StartScreenViewController: UIViewController {
  
  // MARK: UI Elements
  var gameTitleLabel: UILabel!
  var scoreTableView: UITableView!
  var startButton: StartScreenButton!
  var settingsButton: StartScreenButton!
  
  // MARK: Constraints
  var gameLabelWidthConstraint: NSLayoutConstraint!
  var gameLabelTopConstraint: NSLayoutConstraint!
  
  var scoreTableViewWidthConstraint: NSLayoutConstraint!
  var scoreTableViewTopConstraint: NSLayoutConstraint!
  var scoreTableViewHeightConstraint: NSLayoutConstraint!
  
  var startButtonWidthConstraint: NSLayoutConstraint!
  var startButtonTopConstraint: NSLayoutConstraint!
  var startButtonHeightConstraint: NSLayoutConstraint!
  
  var settingsButtonWidthConstraint: NSLayoutConstraint!
  var settingsButtonTopConstraint: NSLayoutConstraint!
  
  var players: [Player] = []
  
  var isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
  
  var customPresentationController: PlayerSelectVCTransitioningDelegate!
  
  // MARK: viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    
    setupLabel()
    setupTableView()
    setupButtons()
    setupConstraints()
    retreiveCoreData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
  }
  
  // MARK: setupLabel
  private func setupLabel() {
    gameTitleLabel = GameTitleLabel(view: self.view)
    view.addSubview(gameTitleLabel)
    gameLabelWidthConstraint = gameTitleLabel.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    gameLabelTopConstraint = gameTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: isFontAccessible ? 0 : 25)
    gameTitleLabel.sizeToFit()
  }
  
  // MARK: setupTableView
  private func setupTableView() {
    scoreTableView = HighScoreTableView(frame: .zero)
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    scoreTableViewWidthConstraint = scoreTableView.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    view.addSubview(scoreTableView)
    scoreTableViewTopConstraint = scoreTableView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: isFontAccessible ? 10 : 50)
    scoreTableViewHeightConstraint = scoreTableView.heightAnchor.constraint(equalToConstant: isFontAccessible ? 375 : 375)
    scoreTableView.sizeToFit()
  }
  
  // MARK: setupButtons
  private func setupButtons() {
    startButton = StartScreenButton(title: NSLocalizedString("START THE GAME", comment: "Start the game"))
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    startButtonWidthConstraint = startButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7)
    startButtonTopConstraint = startButton.topAnchor.constraint(equalTo: scoreTableView.bottomAnchor, constant: isFontAccessible ? 10 : 50)
    startButtonHeightConstraint = startButton.heightAnchor.constraint(equalToConstant: isFontAccessible ? 110 : 50)
    view.addSubview(startButton)
    
    settingsButton = StartScreenButton(title: NSLocalizedString("SETTINGS", comment: "Application Settings"))
    settingsButton.titleLabel?.lineBreakMode = .byCharWrapping
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    settingsButtonWidthConstraint = settingsButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5)
    settingsButtonTopConstraint = settingsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: isFontAccessible ? 10 : 50)
    view.addSubview(settingsButton)
    settingsButton.sizeToFit()
  }
  
  // MARK: setupConstraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      gameLabelWidthConstraint,
      gameLabelTopConstraint,
      gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      scoreTableViewWidthConstraint,
      scoreTableViewTopConstraint,
      scoreTableViewHeightConstraint,
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

      startButtonWidthConstraint,
      startButtonTopConstraint,
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButtonHeightConstraint,
      
      settingsButtonWidthConstraint,
      settingsButtonTopConstraint,
      settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
  // MARK: traitCollectionDidChange
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    
    gameLabelWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    gameLabelTopConstraint.constant = isFontAccessible ? 0 : 25
    scoreTableViewWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    scoreTableViewTopConstraint.constant = isFontAccessible ? 10 : 50
    scoreTableViewHeightConstraint.constant = isFontAccessible ? 375 : 375
    startButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    startButtonTopConstraint.constant = isFontAccessible ? 10 : 50
    startButtonHeightConstraint.constant = isFontAccessible ? 110 : 50
    settingsButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5
    settingsButtonTopConstraint.constant = isFontAccessible ? 10 : 50
  }
}


// MARK: Extension for tableView
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
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.reuseID)!
    cell.textLabel?.text = players[indexPath.row].name
    return cell
  }
  
}


// MARK: Extension for methods
extension StartScreenViewController {
  
  private func retreiveCoreData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let playerFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    playerFetchRequest.sortDescriptors = [
      NSSortDescriptor(key: "topScore", ascending: false)
    ]
    do {
      players = try context.fetch(playerFetchRequest) as! [Player]
      scoreTableView.reloadData()
      print(playerFetchRequest)
    }
    catch {
      print(error)
    }
  }
  
  @objc
  func goToGameViewController() {
    fireHapticFeedback()
    customPresentationController = PlayerSelectVCTransitioningDelegate()
    let vc = PlayerSelectViewController()
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = customPresentationController
    present(vc, animated: true, completion: nil)
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
