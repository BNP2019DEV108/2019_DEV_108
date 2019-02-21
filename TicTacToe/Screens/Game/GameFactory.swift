//
//  GameFactory.swift
//  TicTacToe
//
//  Created by 2019_DEV_108
// @Brief: creates and configures GameViewController

import Foundation
import UIKit

class GameFactory {
    func make() -> UIViewController {
        // gameViewController is a fixed 3x3 grid, but the viewModel is dynamic
        let viewModel = GameViewModelDefault(withGridSize: 3, players: ["🤖","😺"])
        let gameViewController = GameViewController(withViewModel: viewModel)
        viewModel.delegate = gameViewController
        return UINavigationController(rootViewController: gameViewController)
    }
}
