//
//  InterfaceController.swift
//  FirstWatchKitApp WatchKit Extension
//
//  Created by Jørgen Ekeland on 05/10/15.
//  Copyright © 2015 Jørgen Ekeland. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class InterfaceController: WKInterfaceController, WCSessionDelegate  {

    @IBAction func onButtonTapped() {
        let message = ["request": "fireLocalNotification"]
        WCSession.defaultSession().sendMessage(
            message, replyHandler: { (replyMessage) -> Void in
                print("Firing message")
            }) { (error) -> Void in
                print(error)
        }

    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Activate the session on both sides to enable communication.
        if (WCSession.isSupported()) {
            let session = WCSession.defaultSession()
            session.delegate = self // conforms to WCSessionDelegate
            session.activateSession()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    // =========================================================================
    // MARK: - WCSessionDelegate
    
    func sessionWatchStateDidChange(session: WCSession) {
        print(__FUNCTION__)
        print(session)
        print("reachable:\(session.reachable)")
    }
    
    // Received message from iPhone
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        print(__FUNCTION__)
        guard message["request"] as? String == "showAlert" else {return}
        
        let defaultAction = WKAlertAction(
            title: "OK",
            style: WKAlertActionStyle.Default) { () -> Void in
        }
        let actions = [defaultAction]
        
        self.presentAlertControllerWithTitle(
            "Message Received",
            message: message["firstHit"] as? String,
            preferredStyle: WKAlertControllerStyle.Alert,
            actions: actions)
    }}
