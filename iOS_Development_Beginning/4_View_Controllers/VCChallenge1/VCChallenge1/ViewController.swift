//
//  ViewController.swift
//  VCChallenge1
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func showHelloController(_ sender: UIButton) {
        if let password = passwordTextField.text, let userName = loginTextField.text {
            if password == "Password" {
                let helloViewController = HelloViewController()
                helloViewController.userName = userName
                present(helloViewController,
                        animated: true,
                        completion: nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

