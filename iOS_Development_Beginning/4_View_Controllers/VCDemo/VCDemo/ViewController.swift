//
//  ViewController.swift
//  VCDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showSecondViewController(_ sender: UIButton) {
        let secondViewController = SecondViewController()
        present(secondViewController,
                animated: true,
                completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


}

