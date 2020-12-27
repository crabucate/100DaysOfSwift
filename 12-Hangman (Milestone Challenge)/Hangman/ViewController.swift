//
//  ViewController.swift
//  Hangman
//
//  Created by Felix Leitenberger on 30.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var words           = [String]()
    var randomWord      = ""
    var usedLetters     = [String]()
    var wrongAnswers    = 0 {
        didSet {
            if wrongAnswers == 7 {
                statusLabel.text = "You failed! Try a new game!"
                navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }
    
    var promptWord: String {
        var tempWord = ""
        for letter in randomWord {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                tempWord += strLetter
            } else {
                tempWord += "?"
            }
        }
        return tempWord
    }
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusBar: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guess", style: .plain, target: self, action: #selector(showGuessAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startNewGame))
        getWords()
        chooseRandomWord()
        updateUI()
    }
    
    
    func getWords() {
        if let wordURL = Bundle.main.url(forResource: "bioWords", withExtension: "txt") {
            if let text = try? String(contentsOf: wordURL).uppercased() {
                words = text.components(separatedBy: "\n")
            }
        }
    }
    
    
    func chooseRandomWord() {
        if let randomElement = words.randomElement() {
            randomWord = randomElement
        }
    }
    
    
    func updateUI() {
        title = promptWord
        self.statusBar.constant = self.view.bounds.height / 7 * CGFloat(self.wrongAnswers)
        UIView.animate(withDuration: 0.5) {
            self.view.superview?.layoutIfNeeded()
        }
    }
    
    
    @objc func showGuessAlert() {
        let alert = UIAlertController(title: "Enter a letter", message: nil, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            if let text = alert.textFields?[0].text {
                if text.count > 1 {
                    self.wrongAnswers += 1
                    self.updateUI()
                    self.statusLabel.text = "You entered more than one letter!"
                    return
                } else {
                    self.validateGuess(letter: text.uppercased())
                }
            }
        }))
        present(alert, animated: true)
    }
    
    
    func validateGuess(letter: String) {
        guard !usedLetters.contains(letter) else {
            statusLabel.text = "You already tried this letter!"
            wrongAnswers += 1
            self.updateUI()
            return
        }
    
        usedLetters.append(letter)
        
        if randomWord.contains(letter) {
            statusLabel.text = "Got one!"
        } else {
            statusLabel.text = "Noooo..."
            wrongAnswers += 1
        }
        
        if randomWord == promptWord {
            statusLabel.text = "You did it!"
        }
        
        updateUI()
    }
    
    
    @objc func startNewGame() {
        usedLetters.removeAll()
        statusLabel.text = "Tap Guess-Button..."
        chooseRandomWord()
        wrongAnswers = 0
        updateUI()
    }
}
