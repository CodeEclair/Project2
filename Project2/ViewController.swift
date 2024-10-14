//
//  ViewController.swift
//  Project2
//
//  Created by Валерия Беленко on 11/10/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCounter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestion()
        
        // Do any additional setup after loading the view.
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " (Score: \(score))" + "   \(questionsCounter)/10"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        let selectedCountry = countries[sender.tag]
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            
        } else {
            if selectedCountry == "us" || selectedCountry == "uk" {
                       title = "Wrong! That’s the flag of \(selectedCountry.uppercased())"
                   } else {
                       title = "Wrong! That’s the flag of \(selectedCountry.capitalized)"
                   }
                   score -= 1
            
        }
        questionsCounter += 1
        
        if questionsCounter == 10 {
            showFinalScore()
          
        } else{
            
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    func showFinalScore () {
        let ac = UIAlertController(title: "Finish", message: "Your final score is \(score)", preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default, handler: resetGame))
         present(ac, animated: true)
    }
    func resetGame(action: UIAlertAction! = nil) {
           score = 0
           questionsCounter = 0
           askQuestion()
       }
    @objc func shareTapped() {
      
        let vc = UIActivityViewController(activityItems: ["My score in GuessFlag is \(score)!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    
}

