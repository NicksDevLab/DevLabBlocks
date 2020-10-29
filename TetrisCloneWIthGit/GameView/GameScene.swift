//
//  GameScene.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit
import UIKit
import CoreData


final class GameScene: SKScene {
  
  // MARK: Public Variables
  var gameBoard: GameBoard!
  
  var currentPlayerName = (UIApplication.shared.delegate as! AppDelegate).defaults.string(forKey: "currentPlayer") ?? ""
  
  var score = 0 {
    willSet(newValue) {
      currentScoreLabel.text = "\(currentPlayerName) - Score: \(newValue)"
    }
  }
  
  var level = 1 {
    willSet(newValue) {
      currentLevelLabel.text = "Level: \(newValue)"
    }
  }
  
  // MARK: Private Variables
  private var scoreNode = SKNode()
  private var scoreBoardNode: SKShapeNode!
  private var currentScoreLabel: SKLabelNode!
  private var scoreString: NSAttributedString!
  private var currentLevelLabel: SKLabelNode!
  private var levelString: NSAttributedString!
  private var nextPiecePreviewNode: SKShapeNode!
  private var nextPiece: TetrisPiece!
  private var resetButton: SpriteButton!
  private var currentPlayer: Player!
  
  
  override func didMove(to view: SKView) {
    backgroundColor = .systemGray6
    setupGameBoard()
    setupScoreBoard()
    setupNextPiecePreview()
    setupSwipeGestures()
    setupResetButton()
    getPlayer()
    gameBoard.startGame()
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
    let scoreBoardStringAttributes = [
      NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title1),
      NSAttributedString.Key.foregroundColor : UIColor(named: "tetrisOrange")!,
    ]
    scoreString = NSMutableAttributedString(string: "SCORE - \(score)", attributes: scoreBoardStringAttributes)
    currentScoreLabel.attributedText = scoreString
    currentScoreLabel.fontColor = .systemGray
    currentScoreLabel.position = CGPoint(x:  0, y: currentScoreLabel.frame.height * 0.1)
    scoreNode.addChild(currentScoreLabel)
    
    currentLevelLabel = SKLabelNode()
    levelString = NSAttributedString(string: "LEVEL: \(level)", attributes: scoreBoardStringAttributes)
    currentLevelLabel.attributedText = levelString
    currentLevelLabel.fontColor = .systemGray
    currentLevelLabel.position = CGPoint(x: 0, y: -(currentLevelLabel.frame.height + (currentScoreLabel.frame.height * 0.1)))
    scoreNode.addChild(currentLevelLabel)
  }
  
  
  private func setupNextPiecePreview() {
    nextPiecePreviewNode = SKShapeNode(rectOf: CGSize(width: view!.frame.width * 0.25, height: view!.frame.height * 0.12), cornerRadius: 10)
    nextPiecePreviewNode.position = CGPoint(x: scoreBoardNode.frame.maxX + (nextPiecePreviewNode.frame.width / 2) + (view!.frame.width * 0.05), y: 0)
    nextPiecePreviewNode.lineWidth = 2
    nextPiecePreviewNode.strokeColor = UIColor(named: "tetrisOrange")!
    nextPiecePreviewNode.fillColor = UIColor(named: "tetrisLabelBackground")!
    scoreNode.addChild(nextPiecePreviewNode)
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
  
  
  private func setupResetButton() {
    resetButton = SpriteButton(scene: self, text: "PAUSE")
    resetButton.position = CGPoint(x: view!.frame.width * 0.5, y: gameBoard.frame.minY / 2)
    addChild(resetButton)
  }
  
  private var time = 0
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
  
  // MARK: Private Methods
  @objc
  private func movePiece(_ sender: UISwipeGestureRecognizer) {
    
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
  private func rotatePiece() {
    
    guard gameBoard.boardState == .inPlay else { return }
    
    gameBoard.activeGamePiece?.rotate()
    gameBoard.adjustXPositionIfOutOfBounds()
  }
  
  
  @objc
  private func startGame() {
    gameBoard.boardState = .inPlay
    setupResetButton()
  }
  
  
  private func getPlayer() {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    fetchRequest.predicate = NSPredicate(format: "name = %@", currentPlayerName)
    do {
      let fetchResult = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
      if fetchResult.count != 0 {
        currentPlayer = fetchResult[0] as? Player
      }
    } catch {
      print(error)
    }
  }
  
  
  //MARK: Public Methods
  func pauseGame() {
    print("pause game called")
    guard gameBoard.boardState == .inPlay else { return }
    gameBoard.boardState = .paused
    let attributes = [
      NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title3),
      NSAttributedString.Key.foregroundColor : UIColor(named: "tetrisRed")!
    ]
    let pauseView = PauseView(scene: self)
    pauseView.labelView.attributedText = NSAttributedString(string: "Your Score is \(score). Your current record is \(currentPlayer.topScore ?? "0")", attributes: attributes)
    view?.addSubview(pauseView)
  }
  
  
  func updateNext() {
    if nextPiece != nil {
      nextPiece.removeFromParent()
    }
    nextPiece = GamePieceGenerator.createStaticPiece(type: gameBoard.nextGamePiece, size: 20)
    nextPiece.position = CGPoint(x: 0, y: 0)
    nextPiecePreviewNode.addChild(nextPiece)
  }
  
  
  func saveData() {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
    fetchRequest.predicate = NSPredicate(format: "name = %@", currentPlayerName)
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
