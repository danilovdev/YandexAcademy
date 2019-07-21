//
//  NoteDetailsController.swift
//  Notes
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

extension NoteDetailsController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NoteDetailsController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

class NoteDetailsController: UIViewController {
    
    var currentNote: Note?
    
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
    
    @IBOutlet weak var noteTitleTextField: UITextField! {
        didSet {
            noteTitleTextField.delegate = self
        }
    }
    
    @IBOutlet weak var noteContentTextView: UITextView! {
        didSet {
            noteContentTextView.delegate = self
            noteContentTextView.layer.borderWidth = 1
            noteContentTextView.layer.borderColor = UIColor.lightGray.cgColor
            noteContentTextView.layer.cornerRadius = 5.0
        }
    }
    
    @IBAction func openColorPicker(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowColorPicker",
                     sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DDLogDebug("View Controller is loaded")
        
        useDestroyDateSwitcher.isOn = false
        datePicker.isHidden = !useDestroyDateSwitcher.isOn
        
        colorsArray = getDifferentRandomColorsArray()
        
        noteTitleTextField.text = currentNote?.title
        noteContentTextView.text = currentNote?.content
        
        if let selfDestructionDate = currentNote?.selfDestructionDate {
            useDestroyDateSwitcher.isOn = true
            datePicker.date = selfDestructionDate
            datePicker.isHidden = false
        }
        
        if let noteColor = currentNote?.color {
            isUpdateSquaresNeeded = true
            selectedColor = noteColor
        }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentNote?.title = noteTitleTextField.text ?? ""
        currentNote?.content = noteContentTextView.text
        currentNote?.color = selectedColor ?? UIColor.white
        
        if useDestroyDateSwitcher.isOn {
            let selfDestructionDate = datePicker.date
            currentNote?.selfDestructionDate = selfDestructionDate
        } else {
            currentNote?.selfDestructionDate = nil
        }
        
        if let currentNote = currentNote {
            try? fileNoteBook.update(note: currentNote)
        }
    }
    
}

// MARK: - Navigation
extension NoteDetailsController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowColorPicker" {
            if let destination = segue.destination as? ColorPickerController {
                destination.noteColor = selectedColor
                destination.doneHandler = { [weak self] newSelectedColor  in
                    self?.selectedColor = newSelectedColor
                }
            }
        }
    }
}


