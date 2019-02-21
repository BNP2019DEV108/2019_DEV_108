//
//  GameViewModel
//  TicTacToe
//
//  Created by 2019_DEV_108
// @Brief: view model for the game: handles the logic / states

import Foundation
import UIKit

protocol GameViewModelDelegate: class {
    func gameViewModel(_ sender: GameViewModel, updateButtonWithDataSource dataSource: GameButtonDataSource, atIndex index: Int)
    func gameViewModel(_ sender: GameViewModel, updateLabelWithValue value: String)
    func gameViewModelPresentingViewController(_ sender: GameViewModel) -> UIViewController
}

protocol GameViewModel: class {
    var delegate: GameViewModelDelegate? {get set}
    func start()
    func toggleValue(atIndex index: Int)
}

class GameViewModelDefault: GameViewModel {
    enum GameError: Error {
        case cannotSetValue
    }
    
    enum GameResult {
        case ongoing, win(Int), draw
    }
    weak var delegate: GameViewModelDelegate?

    private let gameEmptyValue = -1
    private var gameValues: [Int] = []
    private var turn = 0
    private var currentPlayerIndex: Int {
        return turn % players.count
    }
    private var currentPlayer: String {
        return players[currentPlayerIndex]
    }
    
    private let gridSize: Int
    private let players: [String]

    // MARK: Init
    init(withGridSize gridSize: Int, players: [String]) {
        self.gridSize = gridSize
        self.players = players
    }
    
    // MARK: Private methods
    private func reset() {
        gameValues = [Int](repeating: gameEmptyValue, count: gridSize * gridSize)
        for i in 0..<gameValues.count {
            delegate?.gameViewModel(self, updateButtonWithDataSource: GameButtonDataSource.defaultValue, atIndex: i)
        }
        turn = 0
        delegateUpdatePlayerLabel()
    }
    
    private func delegateUpdatePlayerLabel() {
        let player = players[turn % players.count]
        delegate?.gameViewModel(self, updateLabelWithValue: "\(player)'s turn")
    }
    
    private func set(value: Int, atIndex index: Int) throws -> GameResult {
        guard index >= 0, index < gameValues.count else {
            throw Array.SearchError.outOfRange(index)
        }
        guard gameValues[index] == gameEmptyValue else {
            throw GameError.cannotSetValue
        }
        gameValues[index] = value
        do {
            for findStarIndex in 0..<gridSize {
                if let winningValue = try gameValues.findConsecutiveValues(startingAtIndex: findStarIndex * gridSize, searchStep: 1, limit: gridSize), winningValue != gameEmptyValue {
                    // search array horizontally (indexes 0,3,6, searchStep: 1)
                    return .win(winningValue)
                } else if let winningValue = try gameValues.findConsecutiveValues(startingAtIndex: findStarIndex, searchStep: gridSize, limit: gridSize), winningValue != gameEmptyValue {
                    // search array verticallt (indexes 1,2,3, searchStep: 3)
                    return .win(winningValue)
                }
            }
            if let winningValue = try gameValues.findConsecutiveValues(startingAtIndex: 0, searchStep: gridSize+1, limit: gridSize), winningValue != gameEmptyValue {
                // search array diagonally, top left, bottom right (index 0, searchStep: 4)
                return .win(winningValue)
            } else if let winningValue = try gameValues.findConsecutiveValues(startingAtIndex: gridSize-1, searchStep: gridSize-1, limit: gridSize), winningValue != gameEmptyValue {
                // search array diagonally, top right, bottom left (index 2, searchStep: 2)
                return .win(winningValue)
            }
        } catch {
            throw error
        }
        return gameValues.contains(gameEmptyValue) ? .ongoing : .draw
    }
    
    private func showAlert(withTitle title: String, message: String?) {
        guard let presentingViewController = delegate?.gameViewModelPresentingViewController(self) else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let replayAction = UIAlertAction(title: "Replay", style: .default) { [weak self] _ in
            self?.reset()
        }
        alertController.addAction(replayAction)
        presentingViewController.present(alertController, animated: true, completion: nil)
        
    }
}

extension GameViewModelDefault {
    func start() {
        reset()
    }
    
    
    func toggleValue(atIndex index: Int) {
        do {
            let result = try set(value: currentPlayerIndex, atIndex: index)
            delegate?.gameViewModel(self, updateButtonWithDataSource: GameButtonDataSource(symbol: currentPlayer, isEnabled: false), atIndex: index)
            switch result {
            case .ongoing:
                turn += 1
                delegateUpdatePlayerLabel()
            case .win:
                showAlert(withTitle: "\(currentPlayer) won!", message: "Well done!")
            case .draw:
                showAlert(withTitle: "It's a draw", message: "This actually happens a lot ...")
            }
        } catch {
            print(error)
        }
    }   
}
