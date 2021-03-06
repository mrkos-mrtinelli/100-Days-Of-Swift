//
//  ViewController.swift
//  Project2
//
//  Created by Marcos Martinelli on 11/30/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        totalQuestionsAsked += 1
        
        title = "\(countries[correctAnswer].uppercased())"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(showScore))
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var alertTitle: String
        var message: String
        var alertAction = "Continue"
        
        if sender.tag == correctAnswer {
            alertTitle = "Correct!"
            score += 1
            message = "Your score is \(score)"
        } else {
            alertTitle = "Incorrect."
            score -= 1
            message = "That is the flag for \(countries[sender.tag].uppercased()) "
        }
        
        if totalQuestionsAsked == 3 {
            alertTitle = "Game Over"
            message = "Your final score is \(score)/\(totalQuestionsAsked)"
            alertAction = "Play again!"
            score = 0
            totalQuestionsAsked = 0
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 15, options: [], animations: { sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) }, completion: { _ in sender.transform = .identity })

        showStats(title: alertTitle, message: message, alertAction: alertAction)
        
    }
    // challenge day 22 - add a bar button item to the main view that shows score
    @objc func showScore() {
        let ac = UIAlertController(title: "Current Score", message: "You got \(score) correct out of \(totalQuestionsAsked - 1)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    @objc func showStats(title: String, message: String, alertAction: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: alertAction, style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
}

