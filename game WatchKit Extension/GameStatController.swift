//
//  GameStatController.swift
//  game
//
//  Created by Marta Wozniak on 24/07/15.
//  Copyright (c) 2015 Marta Wozniak. All rights reserved.
//

import Foundation
import WatchKit

class GameStatController: WKInterfaceController{
    
    @IBOutlet weak var currentScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var highScoreLabel: WKInterfaceLabel!
    @IBOutlet weak var gamesPlayedLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        if let data = context as? [String:String]{
            currentScoreLabel.setText(data["currentScore"])
            highScoreLabel.setText(data["highScore"])
            gamesPlayedLabel.setText(data["gamesPlayed"])
        }
    }
}