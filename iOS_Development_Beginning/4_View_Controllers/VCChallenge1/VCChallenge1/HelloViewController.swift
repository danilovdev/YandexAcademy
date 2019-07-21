//
//  HelloViewController.swift
//  VCChallenge1
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    var userName: String?
    
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = userName {
            helloLabel.text = "Hello, \(userName)"
        }
    }

}
