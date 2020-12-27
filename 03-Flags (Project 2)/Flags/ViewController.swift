//
//  ViewController.swift
//  Day19_Project2
//
//  Created by Felix Leitenberger on 14.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var correctAnswer = 0
    var score = 0
    var questionCounter = 0
    var highscore: Int = 0 {
        didSet {
            let alert = UIAlertController(title: "New High Score!", message: "Your new highscore: \(highscore)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "New Game", style: .destructive, handler: { (action) in
                self.questionCounter = 0
                self.score = 0
                self.askQuestion()
                self.saveHighscore()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countries[correctAnswer].uppercased()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
        let defaults = UserDefaults()
        highscore = defaults.integer(forKey: "highscore")
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        navigationItem.title = countries[correctAnswer].uppercased() + " :: Score \(score)"
        questionCounter += 1
    }
    
    
    func saveHighscore() {
        let defaults = UserDefaults()
        defaults.set(highscore, forKey: "highscore")
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.5, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5) {
                sender.transform = CGAffineTransform.identity
            }
            
            var title: String
            var message: String
            
            if sender.tag == self.correctAnswer {
                    title = "Correct!"
                    message = "Well Done!"
                self.score += 1
                } else {
                    title = "Wrong!"
                message = "This is the flag of \(self.countries[self.correctAnswer].uppercased()).\n"
                self.score -= 1
                }
                
            if self.questionCounter < 10 {
                let ac = UIAlertController(title: title, message: message + " Your score is \(self.score).", preferredStyle: .alert)
                let action = UIAlertAction(title: "Continue", style: .default, handler: self.askQuestion)
                           ac.addAction(action)
                self.present(ac, animated: true)
                } else {
                    
                if self.highscore < self.score {
                    self.highscore = self.score
                    } else {
                    let ac = UIAlertController(title: title + "Game over", message: "You achieved \(self.score) points", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "New Game", style: .destructive, handler: { (action) in
                            self.questionCounter = 0
                            self.score = 0
                            self.askQuestion()
                        }))
                    self.present(ac, animated: true)
                    }
                }
            }
        }
        

    
}

