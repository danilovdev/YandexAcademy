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
        
        title = "Экран 2"
        titleTextField.text = helloTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(saveButtonTapped))
        
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(cancelButtonTapped))
        cancelBarButtonItem.tintColor = .red
        navigationItem.rightBarButtonItem = cancelBarButtonItem
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        guard let text = titleTextField.text else { return }
        updateTitleDelegate?.updateTitle(with: text)
        navigationController?.popViewController(animated: true)
    }

    @objc func cancelButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}


