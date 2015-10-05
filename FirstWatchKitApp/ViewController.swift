//
//  ViewController.swift
//  FirstWatchKitApp
//
//  Created by Jørgen Ekeland on 05/10/15.
//  Copyright © 2015 Jørgen Ekeland. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBAction func onPushButtonTapped(sender: AnyObject) {
        // check the reachablity
        if WCSession.defaultSession().reachable == false {
            
            let alert = UIAlertController(
                title: "Failed to send",
                message: "Apple Watch is not reachable.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Cancel,
                handler: nil)
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        
        let place: String! = inputTextField.text
        
        Alamofire.request(.GET, "http://api.trafikanten.no/reisrest/Place/FindPlaces/\(place)")
            .responseJSON { request, response, result in
                switch result {
                case .Success(let json):
                    if let stops = JSON(json).array {
                        let firstStop = stops[0]

                        let message = ["request": "showAlert", "firstHit": firstStop["Name"].string!]
                        WCSession.defaultSession().sendMessage(
                            message, replyHandler: { (replyMessage) -> Void in
                                //
                            }) { (error) -> Void in
                                print(error)
                        }
                        
                        
                        
                        for stop in stops {
                            print(stop["Name"].string)
                        }
                    }
                case .Failure(_, _):
                    print("Error")
                }
        }
        
        
        responseTextView.text = "Hello world!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

