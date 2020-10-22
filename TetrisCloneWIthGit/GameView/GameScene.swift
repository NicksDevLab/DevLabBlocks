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
  var scoreBoardNode = SKNode()
  var currentScoreLabel: SKLabelNode!
  var currentLevelLabel: SKLabelNode!
  var startButton: StartButton!
  var resetButton: ResetButton!
  var pauseButton: PauseButton!
  
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
    presentStartButton()
    
    
  }
  
  
  private func setupGameBoard() {
    gameBoard = GameBoard(viewFrame: self.view!.frame)
    addChild(gameBoard!)
  }
  
  private func setupScoreBoard() {
    
    currentScoreLabel = SKLabelNode(text: "\(currentPlayer) - Score: \(score)")
    currentScoreLabel.fontName = UIFont.systemFont(ofSize: 36, weight: .bold).fontName
    currentScoreLabel.fontColor = .systemGray
    currentScoreLabel.position = CGPoint(x: gameBoard.xPositions.first! + (currentScoreLabel.frame.width / 2),
                                         y: 20)
    scoreBoardNode.addChild(currentScoreLabel)
    
    currentLevelLabel = SKLabelNode(text: "Level: \(level)")
    currentLevelLabel.fontName = UIFont.systemFont(ofSize: 36, weight: .bold).fontName
    currentLevelLabel.fontColor = .systemGray
    currentLevelLabel.position = CGPoint(x: gameBoard.xPositions.first! + (currentLevelLabel.frame.width / 2),
                                         y: -20)
    scoreBoardNode.addChild(currentLevelLabel)
    
    scoreBoardNode.position = CGPoint(x: self.view!.frame.minX, y: self.view!.frame.height * 0.9)
    scoreBoardNode.setScale(0.75)
    self.addChild(scoreBoardNode)
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
  
  func presentStartButton() {
    startButton = StartButton(gameBoard: gameBoard)
    startButton.position = CGPoint(x: view!.frame.width / 2, y: view!.frame.height / 3)
    addChild(startButton)
  }
  
  func setupResetButton() {
    resetButton = ResetButton(gameBoard: gameBoard)
    resetButton.position = CGPoint(x: view!.frame.width * 0.33, y: view!.frame.height / 10)
    addChild(resetButton)
  }
  
  func setupPauseButton() {
    pauseButton = PauseButton(gameBoard: gameBoard)
    pauseButton.position = CGPoint(x: view!.frame.width * 0.66, y: view!.frame.height / 10)
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
