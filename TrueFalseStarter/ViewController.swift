//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // Assign constants/variables
    let questionsPerRound = quizQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var btnChoice1: UIButton!
    @IBOutlet weak var btnChoice2: UIButton!
    @IBOutlet weak var btnChoice3: UIButton!
    @IBOutlet weak var btnChoice4: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    /*
     --------------------------------------------------
     | Functions
     --------------------------------------------------
     */
    
    override func viewDidLoad() {
        // Round off button corners
        btnChoice1.layer.cornerRadius = 8
        btnChoice2.layer.cornerRadius = 8
        btnChoice3.layer.cornerRadius = 8
        btnChoice4.layer.cornerRadius = 8
        nextQuestionButton.layer.cornerRadius = 8
        playAgainButton.layer.cornerRadius = 8
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        clearQuestions()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        // Select a random question based on the count
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quizQuestionsNew.count)
        // Assign random question to 'questionDictionary' constant
        let questionDictionary = quizQuestionsNew[indexOfSelectedQuestion]
        questionField.font = UIFont(name: "HelveticaNeue", size: 14.0)
        questionField.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        questionField.text = questionDictionary.question
        btnInteraction(isEnabled: true, isHidden: false)
        // Check if question is 4 choices or 2 choices for the answer
        if questionDictionary.choices.count == 4 {
            btnChoice1.setTitle(questionDictionary.choices[0], for: .normal)
            btnChoice2.setTitle(questionDictionary.choices[1], for: .normal)
            btnChoice3.setTitle(questionDictionary.choices[2], for: .normal)
            btnChoice4.setTitle(questionDictionary.choices[3], for: .normal)
            nextQuestionButton.isHidden = true
            playAgainButton.isHidden = true
        // If 2 choices, hide the other 2 buttons
        } else if questionDictionary.choices.count == 2 {
            btnChoice1.setTitle(questionDictionary.choices[0], for: .normal)
            btnChoice2.setTitle(questionDictionary.choices[1], for: .normal)
            btnChoice3.isHidden = true
            btnChoice4.isHidden = true
            nextQuestionButton.isHidden = true
            playAgainButton.isHidden = true
        }
    }
    
    // Display score
    func displayScore() {
        // Hide the answer buttons
        btnInteraction(isEnabled: false, isHidden: true)
        // Display play again button
        playAgainButton.isHidden = false
        // Display score with custom message, change font weight/colors back to default
        questionField.font = UIFont(name: "HelveticaNeue", size: 14.0)
        questionField.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    // Function to enable/disable, hide/show buttons
    func btnInteraction(isEnabled: Bool, isHidden: Bool) {
        btnChoice1.isEnabled = isEnabled
        btnChoice1.isHidden = isHidden
        btnChoice2.isEnabled = isEnabled
        btnChoice2.isHidden = isHidden
        btnChoice3.isEnabled = isEnabled
        btnChoice3.isHidden = isHidden
        btnChoice4.isEnabled = isEnabled
        btnChoice4.isHidden = isHidden
    }
    
    // Next round
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    /*
     --------------------------------------------------
     | IBAction/Button functions
     --------------------------------------------------
     */
    
    // Check answer
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = quizQuestionsNew[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.answer
        // Check and compare anwer based on which button was pressed
        if (sender === btnChoice1 && correctAnswer == 0) || (sender === btnChoice2 && correctAnswer == 1) || (sender === btnChoice3 && correctAnswer == 2) || (sender === btnChoice4 && correctAnswer == 3) {
            correctQuestions += 1
            // Change text colors/font weight
            questionField.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
            questionField.textColor = UIColor(red: 0/255.0, green: 147/255.0, blue: 135/255.0, alpha: 1.0)
            questionField.text = "Correct!"
            // Disable choice buttons
            if selectedQuestionDict.choices.count == 2 {
                btnChoice1.isEnabled = false
                btnChoice2.isEnabled = false
                btnChoice3.isHidden = true
                btnChoice4.isHidden = true
            } else if selectedQuestionDict.choices.count == 4 {
                btnInteraction(isEnabled: false, isHidden: false)
            }
        } else {
            questionField.font = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
            questionField.textColor = UIColor(red: 255/255.0, green: 187/255.0, blue: 93/255.0, alpha: 1.0)
            questionField.text = "Sorry, that's incorrect!"// Include to show the correct answer: "The correct answer is \(quizQuestionsNew[indexOfSelectedQuestion].choices[correctAnswer])."
            // Disable choice buttons
            if selectedQuestionDict.choices.count == 2 {
                btnChoice1.isEnabled = false
                btnChoice2.isEnabled = false
                btnChoice3.isHidden = true
                btnChoice4.isHidden = true
            } else if selectedQuestionDict.choices.count == 4 {
                btnInteraction(isEnabled: false, isHidden: false)
            }
        }
        // Remove question from the 'temp' array so it will not be asked twice
        quizQuestionsNew.remove(at: indexOfSelectedQuestion)
        nextQuestionButton.isHidden = false
    }
    
    // Next question
    @IBAction func nextQuestion() {
        nextRound()
        nextQuestionButton.isHidden = true
    }
    
    // Play again/reset round
    @IBAction func playAgain() {
        // Show the answer buttons, reset values for new round
        btnInteraction(isEnabled: true, isHidden: false)
        questionsAsked = 0
        correctQuestions = 0
        clearQuestions()
        nextRound()
    }
    
    /*
     --------------------------------------------------
     | Helper methods
     --------------------------------------------------
     */
    
    // MARK: Helper Methods
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

