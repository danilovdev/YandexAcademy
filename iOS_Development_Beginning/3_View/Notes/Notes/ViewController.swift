//
//  ViewController.swift
//  Notes
//
//  Created by Alexey Danilov on 6/30/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

class ViewController: UIViewController {
    
    var isUpdateSquaresNeeded = false
    
    @IBAction func colorSquareTapped(_ sender: UITapGestureRecognizer) {
        isUpdateSquaresNeeded = false
        for (index, view) in colorSuares.enumerated() {
            view.isSelected = (sender.view == view)
            if sender.view == view {
               selectedColor = colorsArray[index]
            }
        }
    }
    
    @IBOutlet var colorSuares: [ColorSquareView]! {
        didSet {
            for i in 0..<(colorSuares.count - 1) {
                let view = colorSuares[i]
                let gr = UITapGestureRecognizer(target: self, action: #selector(colorSquareTapped))
                gr.numberOfTapsRequired = 1
                view.addGestureRecognizer(gr)
            }
            updateSquares()
        }
    }
    
    private var selectedColor: UIColor? {
        didSet {
            if let selectedColor = selectedColor {
                guard isUpdateSquaresNeeded else { return }
                if colorsArray.first != selectedColor {
                    colorsArray.removeLast()
                    colorsArray.insert(selectedColor, at: 0)
                    colorSuares.forEach { $0.isSelected = false }
                    colorSuares.first?.isSelected = true
                    updateSquares()
                }
            }
        }
    }
    
    private func updateSquares() {
        guard colorsArray.count == 3 else { return }
        for i in 0..<(colorSuares.count - 1) {
            colorSuares[i].type = .normalColor(color: colorsArray[i])
        }
        colorSuares.last?.type = .pallete
    }
    
    var colorsArray: [UIColor] = []
    
    @IBOutlet weak var colorPicker: ColorPicker!
    
    @IBOutlet weak var useDestroyDateSwitcher: UISwitch!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    @IBAction func openColorPicker(_ sender: UILongPressGestureRecognizer) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.colorPicker.isHidden = false
            self?.colorPicker.selectedColor = self?.selectedColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DDLogDebug("View Controller is loaded")
        
        useDestroyDateSwitcher.isOn = false
        datePicker.isHidden = !useDestroyDateSwitcher.isOn
        
        colorPicker.doneHandler = { [weak self] selectedColor  in
            UIView.animate(withDuration: 0.4) {
                self?.isUpdateSquaresNeeded = true
                self?.colorPicker.isHidden = true
                self?.selectedColor = selectedColor
            }
        }
        
        colorsArray = getDifferentRandomColorsArray()
    }
    
    private func getDifferentRandomColorsArray() -> [UIColor] {
        var array = [UIColor]()
        while array.count != 3 {
            let color = UIColor.random()
            if !array.contains(color) {
                array.append(color)
            }
        }
        return array
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectedColor = colorsArray.first
        updateSquares()
        colorSuares.first?.isSelected = true
        
        DDLogDebug("View did appear")
    }
    
    @IBAction func useDestroyDateChanged(_ sender: UISwitch) {
        datePicker.isHidden = !sender.isOn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterNotifications()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        scrollView.contentInset.bottom = 0
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
}

