//
//  ViewController.swift
//  Notes
//
//  Created by Alexey Danilov on 6/30/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DDLogDebug("View Controller is loaded")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DDLogDebug("View did appear")
    }
}

