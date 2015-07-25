//
//  ViewController.swift
//  game
//
//  Created by Marta Wozniak on 24/07/15.
//  Copyright (c) 2015 Marta Wozniak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    var highScoreFromDefaults: Int = 0
    
    var defaults = NSUserDefaults(suiteName: "group.com.kainos.mwozniak.game")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateHighScore()
    }
    
    func updateHighScore(){
        
        if let highscore = defaults!.objectForKey("highscore") as? Int{
            highScoreFromDefaults = highscore
            highScoreLabel.text = "Watch HighScore: \(highScoreFromDefaults)"
        }
        else {
            highScoreLabel.text = "No HighScore yet"
        }
    }
    
    @IBAction func resetHighScore() {
        
        var not = UILocalNotification()
        not.alertBody = "from iPhone!"
        not.fireDate = NSDate().dateByAddingTimeInterval(NSTimeInterval(10))
        not.userInfo = ["highscore": highScoreFromDefaults]
        not.soundName = UILocalNotificationDefaultSoundName // play default sound
        not.category = "myCategory"
        UIApplication.sharedApplication().scheduleLocalNotification(not)
        
        
        defaults?.setInteger(0, forKey: "highscore")
        updateHighScore()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

