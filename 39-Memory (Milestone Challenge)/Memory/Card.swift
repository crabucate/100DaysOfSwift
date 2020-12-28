//
//  Card.swift
//  Memory
//
//  Created by Felix Leitenberger on 17.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

protocol buttonDelegate {
    func didPressButton()
}

class Card: UIButton {
    
    var delegate: buttonDelegate!
    
    var emoji: String
    var row: Int
    var column: Int
    var visible: Bool = false {
        didSet {
            if self.visible {
                self.setImage(nil, for: .normal)
                self.setTitle(self.emoji, for: .normal)
                UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
                
            } else {
                self.setTitle(nil, for: .normal)
                self.setImage(UIImage(named: "pattern"), for: .normal)
                UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        }
    }
    var matched: Bool = false {
        didSet {
            if self.matched == true {
                self.layer.borderColor = UIColor.green.cgColor
                self.layer.borderWidth = 3
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    required init(emoji: String, row: Int, column: Int) {
        self.emoji = emoji
        self.row = row
        self.column = column
        super.init(frame: .zero)
        
        self.titleLabel?.font = .systemFont(ofSize: 5000)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.baselineAdjustment = .alignCenters
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = .white
        
        self.layer.borderWidth = 0
        self.setImage(UIImage(named: "pattern"), for: .normal)
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonTapped() {
        self.visible.toggle()
        delegate.didPressButton()
    }
}
