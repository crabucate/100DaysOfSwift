//
//  ViewController.swift
//  Memory
//
//  Created by Felix Leitenberger on 15.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit



class ViewController: UIViewController, buttonDelegate {
    
    var cards = [Card]()
    var emojis = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        emojis = loadRandomArrayOfEmojis(with: 16).shuffled()
        layoutCards(width: view.bounds.width, height: view.bounds.height)
    }
    
    
    override func viewDidLayoutSubviews() {
        for card in cards {
            card.layer.shadowPath = UIBezierPath(rect: card.bounds).cgPath
            card.layer.shadowRadius = 3
            card.layer.shadowOffset = .zero
            card.layer.shadowOpacity = 0.5
        }
    }
    
    func layoutCards(width: CGFloat, height: CGFloat) {
        let sideOfRect = min(width, height)
        let rows = 4
        let columns = 4
        
        let cardView = UIView(frame: .zero)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.heightAnchor.constraint(equalToConstant: sideOfRect),
            cardView.widthAnchor.constraint(equalToConstant: sideOfRect),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        var emojiIndex = 0
        
        for row in 0 ..< rows {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .fill
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 5
            
            for column in 0 ..< columns {
                let button = Card(emoji: emojis[emojiIndex], row: row, column: column)
                button.delegate = self
                emojiIndex += 1
                cards.append(button)
                horizontalStackView.addArrangedSubview(button)
            }
            stackView.addArrangedSubview(horizontalStackView)
        }
        cardView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5)
        ])}
    
    
    func loadRandomArrayOfEmojis(with size: Int) -> [String] {
        var emojiArray = [String]()
        while emojiArray.count < size {
            var emoji = String.randomEmoji
            
            if emojiArray.contains(emoji) {
                emoji = String.randomEmoji
            } else {
                emojiArray.append(contentsOf: [emoji, emoji])
            }
        }
        return emojiArray
    }
    
    func didPressButton() {
        var visibleCards = [Card]()
        
        for card in cards {
            if card.visible && !card.matched {
                visibleCards.append(card)
            }
        }
        if visibleCards.count == 2 {
            for card in cards {
                card.isEnabled = false
            }
            
            if visibleCards[0].emoji == visibleCards[1].emoji {
                visibleCards[0].matched = true
                visibleCards[0].isEnabled = false
                visibleCards[1].matched = true
                visibleCards[1].isEnabled = false
                
                for card in cards {
                    if !card.matched {
                        card.isEnabled = true
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    visibleCards[0].visible = false
                    visibleCards[1].visible = false
                    for card in self.cards {
                        if !card.matched {
                            card.isEnabled = true
                        }
                    }
                }
            }
        }
    }
}
