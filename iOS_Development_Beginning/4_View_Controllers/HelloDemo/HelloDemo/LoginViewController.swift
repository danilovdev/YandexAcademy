//
//  LoginViewController.swift
//  HelloDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
            nameTextField.addTarget(self,
                                    action: #selector(LoginViewController.textFieldDidChange(_:)),
                                    for: UIControl.Event.editingChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text,
            text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {
                loginButton.isEnabled = false
                return
        }
        loginButton.isEnabled = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = nameTextField.text else { return }
        let user = User(username: username)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        let tabBarController = UITabBarController()
        let helloController = HelloViewController()
        helloController.user = user
        
        let helloIcon = UIImage(named: "hello")?.withRenderingMode(.alwaysTemplate)
        
        helloController.tabBarItem = UITabBarItem(title: "Hello",
                                                  image: helloIcon,
                                                  tag: 1)
        let editController = EditViewController()
        editController.user = user
        
        let editIcon = UIImage(named: "edit")?.withRenderingMode(.alwaysTemplate)
        
        editController.tabBarItem = UITabBarItem(title: "Edit",
                                                 image: editIcon, tag: 2)
        tabBarController.viewControllers = [helloController, editController]
        window?.rootViewController = tabBarController
    }
    
    private func handleEmptyName() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Имя не может быть пустым", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {
            handleEmptyName()
            textField.resignFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        return true
    }
}
