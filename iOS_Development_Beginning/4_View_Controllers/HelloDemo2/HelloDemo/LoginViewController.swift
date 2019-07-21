//
//  LoginViewController.swift
//  HelloDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var user: User?
    
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
        
        navigationController?.setNavigationBarHidden(true, animated: false)

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
        user = User(username: username)
        performSegue(withIdentifier: "ShowTabBar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTabBar" {
            if let destinationTabBarController = segue.destination as? UITabBarController {
                guard destinationTabBarController.viewControllers?.count == 2 else { return }
                if let helloController = destinationTabBarController.viewControllers?[0] as? HelloViewController {
                    helloController.user = user
                }
                if let editController = destinationTabBarController.viewControllers?[1] as? EditViewController {
                    editController.user = user
                }
            }
        }
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
