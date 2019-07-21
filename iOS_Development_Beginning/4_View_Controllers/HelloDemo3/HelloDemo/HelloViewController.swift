//
//  HelloViewController.swift
//  HelloDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

protocol EditNameDelegate {
    
    func updateUserName(with text: String)
}

class HelloViewController: UIViewController {
    
    var user: User?
    
    var userName: String? {
        didSet {
            userNameLabel.text = userName
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let username = user?.username {
            userNameLabel.text =
            "Привет, \(username)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hello"
    }

}

extension HelloViewController: EditNameDelegate {
    
    func updateUserName(with text: String) {
        userName = text
    }
}
