//
//  StopsInterfaceController.swift
//  FirstWatchKitApp
//
//  Created by John Alexander Bye on 20/10/15.
//  Copyright © 2015 Jørgen Ekeland. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class StopsInterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet weak var stopsTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        print("Presenting stops with context \(context)")
        // Initialize WC Session
        
        // Activate the session on both sides to enable communication.
        if (WCSession.isSupported()) {
            let session = WCSession.defaultSession()
            session.delegate = self // conforms to WCSessionDelegate
            session.activateSession()
        }

        // Retrieve data from WS
        let model = context as! Dictionary<String, Int>
        let selection = model["selection"] as Int!
        
        print("You selected \(selection)")
        
        var request: String? = nil
        switch (selection) {
        case 0:
            request = "StopsByLocation"
            break
        case 1:
            request = "StopsByVoice"
            break
        case 2:
            request = "StopsByFavorites"
            break
        default:
            request = nil
        }
        
        guard request != nil else {return}
        print("Sending request to iOS app: \(request)")
        
        let message = ["request": request!]
        WCSession.defaultSession().sendMessage(
            message, replyHandler: { (replyMessage) -> Void in
                print("Firing message")
            }) { (error) -> Void in
                print(error)
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
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        print("Selected stop \(rowIndex)")
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        let stops = message["stops"] as! Array<String>
        print("Data received from iOS app: \(stops)")
        
        stopsTable.setNumberOfRows(stops.count, withRowType: "StopsRowIdentifier")
        
        for (index, stop) in stops.enumerate() {
            //let row = stopsTable.rowControllerAtIndex(index) as! StopsRowController
            //row.nameLabel.setText(stop)
        }
    }
    
}
