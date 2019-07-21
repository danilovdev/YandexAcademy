//
//  SecondViewController.swift
//  VCDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        
        dismiss(animated: true,
                completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
