//
//  GamePieceGenerator.swift
//  TetrisCloneWIthGit
//
//  Created by Nicholas Church on 10/11/20.
//

import SpriteKit


class GamePieceGenerator {
  
  static func createGamePiece(type: GamePiece, size: CGFloat, xPos: [CGFloat], yPos: [CGFloat]) -> TetrisPiece {
    
    var piece: TetrisPiece!
    
    switch type {
    case .square:
      piece = SquareShape(size: size, xPos: xPos, yPos: yPos)
    case .zShape:
      piece = ZShape(size: size, xPos: xPos, yPos: yPos)
    case .zRShape:
      piece = ZRShape(size: size, xPos: xPos, yPos: yPos)
    case .straight:
      piece = StraightShape(size: size, xPos: xPos, yPos: yPos)
    case .tShape:
      piece = TShape(size: size, xPos: xPos, yPos: yPos)
    case .lShape:
      piece = LShape(size: size, xPos: xPos, yPos: yPos)
    case .lRShape:
      piece = LShape(size: size, xPos: xPos, yPos: yPos)
    }
    
    return piece
  }
  
  static func createStaticPiece(type: GamePiece, size: CGFloat) -> TetrisPiece {
    
    var piece: TetrisPiece!
    
    switch type {
    case .square:
      piece = SquareShape(size: size)
    case .zShape:
      piece = ZShape(size: size)
    case .zRShape:
      piece = ZRShape(size: size)
    case .straight:
      piece = StraightShape(size: size)
    case .tShape:
      piece = TShape(size: size)
    case .lShape:
      piece = LShape(size: size)
    case .lRShape:
      piece = LShape(size: size)
    }
    
    for node in piece.children {
      if let piece = node as? BaseNode {
        piece.colorNode()
      }
    }
    return piece
  }
  
}


enum GamePiece: UInt32 {
  
  case square, straight, zShape, zRShape, tShape, lShape, lRShape
  
  static private let _count: GamePiece.RawValue = {
    var maxValue: UInt32 = 0
    while let _ = GamePiece(rawValue: maxValue) {
        maxValue += 1
    }
    return maxValue
  }()
  
  static func random() -> GamePiece {
    let rand = arc4random_uniform(self._count)
    return GamePiece(rawValue: rand)!
  }
}

