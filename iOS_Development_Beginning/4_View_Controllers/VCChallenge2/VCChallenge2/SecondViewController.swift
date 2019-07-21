//
//  SecondViewController.swift
//  VCChallenge2
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

protocol UpdateTitleDelegate: class {
    
    func updateTitle(with text: String)
}

class SecondViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    
    var helloTitle: String?
    
    weak var updateTitleDelegate: UpdateTitleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = helloTitle
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let text = titleTextField.text else { return }
        updateTitleDelegate?.updateTitle(with: text)
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true,
                completion: nil)
    }

}
