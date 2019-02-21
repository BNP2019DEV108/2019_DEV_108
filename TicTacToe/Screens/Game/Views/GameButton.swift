//
//  GameButton.swift
//  TicTacToe
//
//  Created by 2019_DEV_108 

import UIKit

struct GameButtonDataSource {
    var symbol: String?
    var isEnabled: Bool
}

extension GameButtonDataSource {
    
    static var defaultValue: GameButtonDataSource {
        return GameButtonDataSource(symbol: nil, isEnabled: true)
    }
}

class GameButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }
    
    func setup(withDataSource dataSource: GameButtonDataSource) {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        setTitle(dataSource.symbol, for: .normal)
        isUserInteractionEnabled = dataSource.isEnabled
    }
}
