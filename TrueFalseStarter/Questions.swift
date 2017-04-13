//
//  Questions.swift
//  TrueFalseStarter
//
//  Created by Brandon Ore on 4/11/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

// Custom data type
struct QuestionStruct {
    let question: String
    let choices: [String]
    let answer: Int
}

// Data model
var quizQuestions: [QuestionStruct] = [
    QuestionStruct(question: "Which of the following names has Princess Zelda not gone by?", choices: ["Zelda", "Sheik", "Tetra", "Malon"], answer: 3),
    QuestionStruct(question: "In the game Halo, what is the name of Master Chief's AI sidekick?", choices: ["Cortana", "Arbiter", "343 Guilty Spark", "Ghost"], answer: 0),
    QuestionStruct(question: "Which of the following takes place in a dystopian underwater city called 'Rapture'?", choices: ["Half-Life", "Fallout", "Bioshock", "God of War"], answer: 2),
    QuestionStruct(question: "What 64-bit Sega System was a predecessor to the Playstation and Nintendo 64?", choices: ["Dreamcast", "Commodore 128", "3DO", "Saturn"], answer: 3),
    QuestionStruct(question: "Why did Princess Peach invite Mario to the castle in Mario 64?", choices: ["She was worried Bowser would attack", "She baked him a cake", "To go on a date", "To pose for a painting"], answer: 1),
    QuestionStruct(question: "What is the general cause of the RRoD (Red Ring of Death) on the Xbox 360?", choices: ["Power failure", "Excessive heat to the CPU/GPU", "No video signal", "HDD Connection issue"], answer: 1),
    QuestionStruct(question: "What is the famous scene that happens in the Macalania Woods (Final Fantasy X)?", choices: ["Seymour kills Auron", "Tidus and Yuna share their first kiss", "Rikku kills Wakka for hating the Al Bhed", "Seymour kills Tidus"], answer: 1),
    QuestionStruct(question: "What is the name of the captain of the Pillar of Autumn?", choices: ["James Cutter", "Jake Finn", "Jacob Flitch", "Jacob Keyes"], answer: 3),
    QuestionStruct(question: "In Doom II, on Ultra Violence mode, which monster makes the least amount of appearances?", choices: ["Commander Keen", "Spider Mastermind", "The Icon of Sin", "Cyberdemon"], answer: 2),
    QuestionStruct(question: "Who was the famous pop idol in Persona 4?", choices: ["Rise Kujikawa", "Yukiko Amagi", "Chie Satonaka", "Naoto Shriogane"], answer: 0),
    QuestionStruct(question: "Do you ever see Gordan Freeman's face in the Half-Life series?", choices: ["Yes", "No"], answer: 1),
    QuestionStruct(question: "In Mass Effect 2, you can punch a reporter", choices: ["Yes", "No"], answer: 0)
    
]

// Temp array to hold questions
var quizQuestionsNew: [QuestionStruct] = []

// Function to re-assign questions to temp array at the start of a new game
func clearQuestions() {
    for question in quizQuestions {
        quizQuestionsNew.append(question)
    }
}
