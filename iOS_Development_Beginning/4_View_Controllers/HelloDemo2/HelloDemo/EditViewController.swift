//
//  EditViewController.swift
//  HelloDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var editNameTextField: UITextField! {
        didSet {
            editNameTextField.delegate = self
        }
    }
    
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        editNameTextField.text = user?.username
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let text = editNameTextField.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {
            handleEmptyName()
            view.endEditing(true)
            return
        }
        
        view.endEditing(true)
    }
    
    private func handleEmptyName() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Имя не может быть пустым", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default) { [weak self] _ in
                                        self?.editNameTextField.text = self?.user?.username
        }
        alert.addAction(okAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }

}

extension EditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {
            handleEmptyName()
            textField.resignFirstResponder()
            return true
        }
        user?.username = text
        textField.resignFirstResponder()
        return true
    }
}
