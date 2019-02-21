//
//  GameViewController.swift
//  TicTacToe
//
//  Created by 2019_DEV_108
// @Brief: Handles the UI of the game

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet var gameButtons: [GameButton]!
    let viewModel: GameViewModel
    init(withViewModel viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.start()
    }
    
    // MARK: Private Methods
    private func configureUI() {
        label.font = UIFont.boldSystemFont(ofSize: 40)
        gameButtons.forEach { button in
            button.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: Button Actions
    @objc func gameButtonTapped(_ button: UIButton) {
        viewModel.toggleValue(atIndex: button.tag)
    }
}

extension GameViewController: GameViewModelDelegate {
    func gameViewModel(_ sender: GameViewModel, updateButtonWithDataSource dataSource: GameButtonDataSource, atIndex index: Int) {
        let gameButton = gameButtons.first { button -> Bool in
            return button.tag == index
        }
        gameButton?.setup(withDataSource: dataSource)
    }
    func gameViewModel(_ sender: GameViewModel, updateLabelWithValue value: String) {
        label.text = value
    }
    func gameViewModelPresentingViewController(_ sender: GameViewModel) -> UIViewController {
        return self
    }
}

