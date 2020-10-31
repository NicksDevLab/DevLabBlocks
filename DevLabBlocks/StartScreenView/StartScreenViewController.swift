//
//  StartScreenViewController.swift
//  DevLabBlocks
//
//  Created by Nicholas Church on 10/5/20.
//

import UIKit
import CoreData


final class StartScreenViewController: UIViewController {
  
  // MARK: UI Elements
  private var gameTitleLabel: UILabel!
  private var scoreTableView: UITableView!
  private var startButton: StartScreenButton!
  private var settingsButton: StartScreenButton!
  
  // MARK: Constraints
  private var gameLabelWidthConstraint: NSLayoutConstraint!
  
  private var scoreTableViewWidthConstraint: NSLayoutConstraint!
  
  private var startButtonWidthConstraint: NSLayoutConstraint!
  
  private var settingsButtonWidthConstraint: NSLayoutConstraint!
  
  private var players: [Player] = []
  
  private var isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
  
  private var customPresentationController: PlayerSelectVCTransitioningDelegate!
  
  private var safeFrame: CGSize!
  
  // MARK: viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray6
    safeFrame = CGSize(width: view.frame.width - (view.safeAreaInsets.left + view.safeAreaInsets.right),
                       height: view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom))
    setupLabel()
    setupTableView()
    setupButtons()
    setupConstraints()
    retreiveCoreData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
    retreiveCoreData()
  }
  
  // MARK: setupLabel
  private func setupLabel() {
    gameTitleLabel = GameTitleLabel(view: self.view)
    view.addSubview(gameTitleLabel)
    gameLabelWidthConstraint = gameTitleLabel.widthAnchor.constraint(equalToConstant: isFontAccessible ? safeFrame.width * 0.9 : safeFrame.width * 0.7)
    gameTitleLabel.sizeToFit()
  }
  
  // MARK: setupTableView
  private func setupTableView() {
    scoreTableView = HighScoreTableView(frame: .zero)
    scoreTableView.delegate = self
    scoreTableView.dataSource = self
    scoreTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
    scoreTableViewWidthConstraint = scoreTableView.widthAnchor.constraint(equalToConstant: isFontAccessible ? safeFrame.width * 0.9 : safeFrame.width * 0.7)
    view.addSubview(scoreTableView)
    scoreTableView.sizeToFit()
  }
  
  // MARK: setupButtons
  private func setupButtons() {
    startButton = StartScreenButton(title: NSLocalizedString(isFontAccessible ? "START" : "START THE GAME", comment: "Start the game"))
    startButton.addTarget(self, action: #selector(goToGameViewController), for: .touchUpInside)
    startButtonWidthConstraint = startButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? safeFrame.width * 0.9 : view.frame.width * 0.7)
    view.addSubview(startButton)
    
    settingsButton = StartScreenButton(title: NSLocalizedString("SETTINGS", comment: "Application Settings"))
    settingsButton.titleLabel?.lineBreakMode = .byCharWrapping
    settingsButton.addTarget(self, action: #selector(goToSettingsViewController), for: .touchUpInside)
    settingsButtonWidthConstraint = settingsButton.widthAnchor.constraint(equalToConstant: isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5)
    view.addSubview(settingsButton)
    settingsButton.sizeToFit()
  }
  
  // MARK: setupConstraints
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      gameLabelWidthConstraint,
      gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameTitleLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeFrame.height * 0.10),

      scoreTableViewWidthConstraint,
      scoreTableView.heightAnchor.constraint(equalToConstant: safeFrame.height * 0.44),
      scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      scoreTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(safeFrame.height * 0.03)),

      startButtonWidthConstraint,
      startButton.heightAnchor.constraint(equalToConstant: 45),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(safeFrame.height * 0.2)),
      
      settingsButtonWidthConstraint,
      settingsButton.heightAnchor.constraint(equalToConstant: 45),
      settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      settingsButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(safeFrame.height * 0.07))
    ])
  }
  
  // MARK: traitCollectionDidChange
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    isFontAccessible = UIApplication.shared.preferredContentSizeCategory.isAccessibilityCategory
    startButton.setTitle(NSLocalizedString(isFontAccessible ? "START" : "START THE GAME", comment: "Start the game"), for: .normal)
    gameLabelWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    scoreTableViewWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.9 : view.frame.width * 0.7
    startButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.7
    settingsButtonWidthConstraint.constant = isFontAccessible ? view.frame.width * 0.7 : view.frame.width * 0.5

  }
}


// MARK: Extension for tableView
extension StartScreenViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = tableView.dequeueReusableHeaderFooterView(withIdentifier: TetrisTableViewHeaderView.reuseID) as! TetrisTableViewHeaderView
    return label
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HighScoreTableViewCell.reuseID) as! HighScoreTableViewCell
    cell.nameLabel.text = "\(players[indexPath.row].name!)"
    cell.scoreLabel.text = "\(players[indexPath.row].topScore!)"
    return cell
  }
  
}


// MARK: Extension for methods
extension StartScreenViewController {
  
  private func retreiveCoreData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let playerFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    do {
      players = try context.fetch(playerFetchRequest) as! [Player]
      players.sort{ (first, second) -> Bool in
        return Int(first.topScore!)! > Int(second.topScore!)!
      }
      players.removeAll() { player in
        return Int(player.topScore!)! <= 0
      }
      scoreTableView.reloadData()
    }
    catch {
      print(error)
    }
  }
  
  @objc
  private func goToGameViewController() {
    fireHapticFeedback()
    customPresentationController = PlayerSelectVCTransitioningDelegate()
    let vc = PlayerSelectViewController()
    vc.thisParent = self
    vc.modalPresentationStyle = .custom
    vc.transitioningDelegate = customPresentationController
    present(vc, animated: true, completion: nil)
  }
  
  @objc
  private func goToSettingsViewController() {
    fireHapticFeedback()
    let settingsVC = SettingsViewController()
    navigationController?.pushViewController(settingsVC, animated: true)
  }
  
  private func fireHapticFeedback() {
    let feedback = UIImpactFeedbackGenerator(style: .medium)
    feedback.impactOccurred()
  }
}
