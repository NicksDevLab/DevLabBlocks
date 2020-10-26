//
//  GameScene.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit
import UIKit
import CoreData


class GameScene: SKScene {
  
  var gameBoard: GameBoard!
  var scoreNode = SKNode()
  var scoreBoardNode: SKShapeNode!
  var currentScoreLabel: SKLabelNode!
  var currentLevelLabel: SKLabelNode!
  var resetButton: SpriteButton!
  var pauseButton: SpriteButton!
  
  let navController = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).navigationController
  var currentPlayer = (UIApplication.shared.delegate as! AppDelegate).defaults.string(forKey: "currentPlayer") ?? ""
  
  var score = 0 {
    willSet(newValue) {
      currentScoreLabel.text = "\(currentPlayer) - Score: \(newValue)"
    }
  }
  
  var level = 1 {
    willSet(newValue) {
      currentLevelLabel.text = "Level: \(newValue)"
    }
  }
  
  override func didMove(to view: SKView) {
    backgroundColor = .systemGray6
    setupGameBoard()
    setupScoreBoard()
    setupSwipeGestures()
    setupResetButton()
    setupPauseButton()
    gameBoard.startGame()
  }
  
  
  private func setupGameBoard() {
    gameBoard = GameBoard(viewFrame: self.view!.frame)
    addChild(gameBoard!)
  }
  
  private func setupScoreBoard() {
    
    scoreNode.position = CGPoint(x: gameBoard.xPositions.first! + (view!.frame.width * 0.35), y: view!.frame.height - (view!.frame.height * 0.075))
    addChild(scoreNode)
    
    scoreBoardNode = SKShapeNode(rectOf: CGSize(width: view!.frame.width * 0.7, height: view!.frame.height * 0.1), cornerRadius: 10)
    scoreBoardNode.lineWidth = 2
    scoreBoardNode.strokeColor = UIColor(named: "tetrisBlue")!
    scoreBoardNode.fillColor = UIColor(named: "tetrisLabelBackground")!
    scoreNode.addChild(scoreBoardNode)
                                 
    currentScoreLabel = SKLabelNode(text: "\(currentPlayer) - Score: \(score)")
    currentScoreLabel.fontName = UIFont.systemFont(ofSize: 36, weight: .bold).fontName
    currentScoreLabel.fontColor = .systemGray
    currentScoreLabel.position = CGPoint(x:  0,
                                         y: 20)
    scoreNode.addChild(currentScoreLabel)
    
    currentLevelLabel = SKLabelNode(text: "Level: \(level)")
    currentLevelLabel.fontName = UIFont.systemFont(ofSize: 36, weight: .bold).fontName
    currentLevelLabel.fontColor = .systemGray
    currentLevelLabel.position = CGPoint(x: 0,
                                         y: -20)
    scoreNode.addChild(currentLevelLabel)
  }
  
  private func setupSwipeGestures() {
    
    let swipeDirections: [UISwipeGestureRecognizer.Direction] = [.left, .right, .down]
    for direction in swipeDirections {
      let gesture = UISwipeGestureRecognizer(target: self, action: #selector(movePiece(_:)))
      gesture.direction = direction
      self.view!.addGestureRecognizer(gesture)
    }
    
    let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToTapLocation))
    singleTapGesture.numberOfTapsRequired = 1
    self.view?.addGestureRecognizer(singleTapGesture)
    
    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(rotatePiece))
    doubleTapGesture.numberOfTapsRequired = 2
    self.view?.addGestureRecognizer(doubleTapGesture)
  }
  
  func setupResetButton() {
    resetButton = SpriteButton(view: view!, text: "RESET")
    resetButton.position = CGPoint(x: view!.frame.width * 0.3, y: view!.frame.height / 12)
    addChild(resetButton)
  }
  
  func setupPauseButton() {
    pauseButton = SpriteButton(view: view!, text: "PAUSE")
    pauseButton.position = CGPoint(x: view!.frame.width * 0.7, y: view!.frame.height / 12)
    addChild(pauseButton)
  }
  
  var time = 0
  override func update(_ currentTime: TimeInterval) {
    time += 1
    if gameBoard?.boardState == .inPlay {
      if time % gameBoard.gameSpeed == 0 {
        gameBoard.movePiece(.down)
      }
    }
  }
}



// MARK: Methods Extension
extension GameScene {
  
  @objc
  func movePiece(_ sender: UISwipeGestureRecognizer) {
    
    guard gameBoard.boardState == .inPlay else { return }
    
    switch sender.direction {
    case .left:
      gameBoard.movePiece(.left)
    case .right:
      gameBoard.movePiece(.right)
    case .down:
      gameBoard.movePiece(.bottom)
    default:
      return
    }
  }
  
  @objc
  func rotatePiece() {
    
    guard gameBoard.boardState == .inPlay else { return }
    
    gameBoard.activeGamePiece?.rotate()
    gameBoard.adjustXPositionIfOutOfBounds()
  }
  
  @objc
  func moveToTapLocation(_ sender: UITapGestureRecognizer) {
    
    guard gameBoard.activeGamePiece != nil else { return }

    if gameBoard.activeGamePiece!.position.x > sender.location(in: self.view).x {
      
    } else {
 
    }
  }
  
  @objc
  private func startGame() {
    gameBoard.boardState = .inPlay
    setupResetButton()
    setupPauseButton()
  }
  
  func saveData() {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    fetchRequest.predicate = NSPredicate(format: "name = %@", currentPlayer)
    do {
      let fetchResult = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
      if fetchResult.count != 0 {
        let player = fetchResult[0] as! Player
        if score > Int(player.topScore!)! {
          player.setValue(String(describing: score), forKey: "topScore")
        }
        player.setValue(Date(), forKey: "lastPlayed")
        try managedObjectContext.save()
      }
    } catch {
      print(error)
    }
  }
  
  func gameOver() {
    let gameOverView = UIView()
    gameOverView.translatesAutoresizingMaskIntoConstraints = false
    gameOverView.backgroundColor = .green
    gameOverView.layer.cornerRadius = 10
    view?.addSubview(gameOverView)
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .purple
    button.setTitle("Home", for: .normal)
    button.addTarget(self, action: #selector(goToHomeScreen), for: .touchUpInside)
    gameOverView.addSubview(button)
    
    NSLayoutConstraint.activate([
      gameOverView.centerXAnchor.constraint(equalTo: view!.centerXAnchor),
      gameOverView.centerYAnchor.constraint(equalTo: view!.centerYAnchor),
      gameOverView.widthAnchor.constraint(equalToConstant: view!.frame.width * 0.8),
      gameOverView.heightAnchor.constraint(equalToConstant: view!.frame.width * 0.8),
      
      button.centerXAnchor.constraint(equalTo: gameOverView.centerXAnchor),
      button.bottomAnchor.constraint(equalTo: gameOverView.bottomAnchor, constant: -25)
    ])
    
  }
  
  @objc
  func goToHomeScreen() {
    let navController = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).navigationController
    navController?.popToRootViewController(animated: true)
  }
  
}
