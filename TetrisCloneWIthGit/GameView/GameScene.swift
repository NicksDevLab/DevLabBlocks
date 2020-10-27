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
  var scoreString: NSAttributedString!
  
  var currentLevelLabel: SKLabelNode!
  var levelString: NSAttributedString!
  
  var nextPieceNode: SKShapeNode!
  var nextPiece: TetrisPiece!
  
  var resetButton: SpriteButton!
  
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
    updateNext()
    setupSwipeGestures()
    setupResetButton()
    gameBoard.startGame()
  }
  

  func updateNext() {
    nextPieceNode = SKShapeNode(rectOf: CGSize(width: view!.frame.width * 0.25, height: view!.frame.height * 0.12), cornerRadius: 10)
    nextPieceNode.position = CGPoint(x: scoreBoardNode.frame.maxX + (nextPieceNode.frame.width / 2) + (view!.frame.width * 0.05), y: 0)
    nextPieceNode.lineWidth = 2
    nextPieceNode.strokeColor = UIColor(named: "tetrisOrange")!
    nextPieceNode.fillColor = UIColor(named: "tetrisLabelBackground")!
    
    nextPiece = GamePieceGenerator.createStaticPiece(type: gameBoard.nextGamePiece, size: 20)
    nextPiece.position = CGPoint(x: 0, y: 0)
    nextPieceNode.addChild(nextPiece)
    scoreNode.addChild(nextPieceNode)
  }
  
  
  private func setupGameBoard() {
    gameBoard = GameBoard(viewFrame: self.view!.frame)
    addChild(gameBoard!)
  }
  
  private func setupScoreBoard() {
    
    scoreNode.position = CGPoint(x: gameBoard.frame.minX + (view!.frame.width * 0.3), y: gameBoard.frame.maxY + (view!.frame.height * 0.075))
    addChild(scoreNode)
    
    scoreBoardNode = SKShapeNode(rectOf: CGSize(width: view!.frame.width * 0.6, height: view!.frame.height * 0.12), cornerRadius: 10)
    scoreBoardNode.lineWidth = 2
    scoreBoardNode.strokeColor = UIColor(named: "tetrisBlue")!
    scoreBoardNode.fillColor = UIColor(named: "tetrisLabelBackground")!
    scoreNode.addChild(scoreBoardNode)
                                 
    currentScoreLabel = SKLabelNode()
    scoreString = NSAttributedString(string: "\(currentPlayer) - Score: \(score)")
    currentScoreLabel.attributedText = scoreString
    currentScoreLabel.fontColor = .systemGray
    currentScoreLabel.position = CGPoint(x:  0, y: 20)
    scoreNode.addChild(currentScoreLabel)
    
    currentLevelLabel = SKLabelNode()
    levelString = NSAttributedString(string: "Level: \(level)")
    currentLevelLabel.attributedText = levelString
    currentLevelLabel.fontColor = .systemGray
    currentLevelLabel.position = CGPoint(x: 0, y: -20)
    scoreNode.addChild(currentLevelLabel)
  }
  
  
  private func setupSwipeGestures() {
    
    let swipeDirections: [UISwipeGestureRecognizer.Direction] = [.left, .right, .down]
    for direction in swipeDirections {
      let gesture = UISwipeGestureRecognizer(target: self, action: #selector(movePiece(_:)))
      gesture.direction = direction
      self.view!.addGestureRecognizer(gesture)
    }
    
    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(rotatePiece))
    doubleTapGesture.numberOfTapsRequired = 2
    self.view?.addGestureRecognizer(doubleTapGesture)
  }
  
  func setupResetButton() {
    resetButton = SpriteButton(scene: self, text: "PAUSE")
    resetButton.position = CGPoint(x: view!.frame.width * 0.5, y: gameBoard.frame.minY / 2)
    addChild(resetButton)
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
  private func startGame() {
    gameBoard.boardState = .inPlay
    setupResetButton()
  }
  
  func pauseGame() {
    guard gameBoard.boardState == .inPlay else { return }
    gameBoard.boardState = .paused
    let pauseView = PauseView(scene: self)
    pauseView.labelView.text = "Your Score \(scoreString.string)"
    view?.addSubview(pauseView)
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
  
}
