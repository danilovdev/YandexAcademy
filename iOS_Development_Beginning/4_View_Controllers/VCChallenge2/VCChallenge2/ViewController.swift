//
//  ViewController.swift
//  VCChallenge2
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    var helloTitle: String? {
        didSet {
            titleLabel.text = helloTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloTitle = "Привет!"
    }
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        let secondController = SecondViewController()
        secondController.helloTitle = helloTitle
        secondController.updateTitleDelegate = self
        present(secondController,
                animated: true,
                completion: nil)
    }


}

extension ViewController: UpdateTitleDelegate {
    
    func updateTitle(with text: String) {
        helloTitle = text
    }
}

