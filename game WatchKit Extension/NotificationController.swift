//
//  NotificationController.swift
//  game WatchKit Extension
//
//  Created by Marta Wozniak on 24/07/15.
//  Copyright (c) 2015 Marta Wozniak. All rights reserved.
//

import WatchKit
import Foundation


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var alertLabel: WKInterfaceLabel!
    
    @IBOutlet weak var highScoreLabel: WKInterfaceLabel!
    
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceiveLocalNotification(localNotification: UILocalNotification, withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a local notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        // After populating your dynamic notification interface call the completion block.
        
        alertLabel.setText(localNotification.alertBody)
        if let userInfo = localNotification.userInfo as? [String: Int]{
            if let highScore = userInfo["highscore"]{
                highScoreLabel.setText("Last HighScore: \(highScore)")
            }
        }
        
        completionHandler(.Custom)
    }
    
    
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        // This method is called when a remote notification needs to be presented.
        // Implement it if you use a dynamic notification interface.
        // Populate your dynamic notification interface as quickly as possible.
        //
        
        if let highScore = remoteNotification["highscore"] as? String{
            
            if !highScore.isEmpty{
                highScoreLabel.setText("Last HighScore: \(highScore)")
            }
            
            if let remoteaps:NSDictionary = remoteNotification["aps"] as? NSDictionary{
                if let remoteAlert:NSDictionary = remoteaps["alert"] as? NSDictionary{
                    if let remotebody = remoteAlert["body"] as? String {
                        alertLabel.setText(remotebody)
                    }
                }
            }

            completionHandler(.Custom)
        }

    }
    
}
