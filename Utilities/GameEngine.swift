//
//  SwiftUIView.swift
//  
//
//  Created by Marvin Hülsmann on 13.01.24.
//

import SwiftUI
import Foundation

/// All avaible Challenge on the Map
enum Challenges {
    case welcome
    case compass
    case seek
    case jungle
    case lighttower
    case boat
}


/// Logic behind the BalancyQuest game, e. x. provide the gameState
class GameEngine {
    var currentGameState: Challenges
    
    init(currentGameState: Challenges) {
        self.currentGameState = Challenges.welcome
    }
    
    func setGameState(newGameState: Challenges) {
        self.currentGameState = newGameState
    }
    
    func updateGameState() {
        switch self.currentGameState {
        case .welcome:
            self.currentGameState = .compass
        case .compass:
            self.currentGameState = .seek
        case .seek:
            self.currentGameState = .jungle
        case .jungle:
            self.currentGameState = .lighttower
        case .lighttower:
            self.currentGameState = .boat
        case .boat:
            self.currentGameState = .welcome
        }
    }
}
