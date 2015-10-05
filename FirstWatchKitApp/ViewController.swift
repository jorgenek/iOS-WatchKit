//
//  ViewController.swift
//  FirstWatchKitApp
//
//  Created by Jørgen Ekeland on 05/10/15.
//  Copyright © 2015 Jørgen Ekeland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var responseTextView: UITextView!
    
    @IBAction func onPushButtonTapped(sender: AnyObject) {
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

