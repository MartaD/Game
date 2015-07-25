//
//  InterfaceController.swift
//  game WatchKit Extension
//
//  Created by Marta Wozniak on 24/07/15.
//  Copyright (c) 2015 Marta Wozniak. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    @IBOutlet weak var resultLabel: WKInterfaceLabel!
    @IBOutlet weak var oponentSymbol: WKInterfaceImage!

    let defaults = NSUserDefaults(suiteName: "group.com.kainos.mwozniak.game")!
    
    let symbols = ["rock", "paper", "scissors"]
    var score = 0
    var gamesCounter = 0
    var highScore = 0
    
    @IBAction func chooseRock() {
        play(symbols[0])
    }

    @IBAction func choosePaper() {
        play(symbols[1])
    }
    
    @IBAction func chooseScissors() {
        play(symbols[2])
    }
    
    @IBAction func showGameStat() {
        highScore = getHighScoreFromDefaults()
        pushControllerWithName("Game Stats", context: ["currentScore": "\(score)", "highScore": "\(highScore)", "gamesPlayed": "\(gamesCounter)"])
    }
    
    func play(symbol: String){
        
        gamesCounter+=1
        
        let oponentPick = symbols[Int(arc4random_uniform(3))]
        oponentSymbol.setImage(UIImage(named: oponentPick))
        
        if oponentPick == symbol {
            resultLabel.setText("Tie. +1")
            score += 1
        }
        else {
            var won = false
            
            switch symbol{
            case "rock":
                if oponentPick == "scissors"{
                    won = true
                }
            case "paper":
                if oponentPick == "rock"{
                    won = true
                }
            case "scissors":
                if oponentPick == "paper" {
                    won = true
                }
            default: resultLabel.setText("unrecognized symbol")
            }
            
            if won {
                resultLabel.setText("You won! +5")
                score += 5
            } else {
                resultLabel.setText("You lost. -2")
                score -= 2
            }
        }
        scoreLabel.setText("\(score)")
        updateHighScore()
    }
    
    func updateHighScore(){
        highScore = getHighScoreFromDefaults()
        
        if(score > highScore){
            defaults.setObject(score, forKey: "highscore")
            defaults.synchronize();
        }
    }
    
    func getHighScoreFromDefaults() -> Int{
        var highScoreFromDefaults = defaults.objectForKey("highscore") as? Int
        
        return (highScoreFromDefaults != nil) ? highScoreFromDefaults! : 0
    }
    
    @IBAction func resetGame() {
        oponentSymbol.setImage(nil)
        score = 0
        gamesCounter = 0
        resultLabel.setText("Tap Icon to start!")
        scoreLabel.setText("0")
    }
}
