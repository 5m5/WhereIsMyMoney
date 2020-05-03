//
//  NewRecordViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

final class NewRecordViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var recordTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var recordName: UITextField!
    @IBOutlet var total: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var count: UITextField!
    @IBOutlet var recordDatePicker: UIDatePicker!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        setTextFieldsDelegates()
        addDoneButtonOnKeyboard()
        total.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    // MARK: - IBActions
    @IBAction func canceButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: Text field delegate
extension NewRecordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldDidChanged() {
        saveButton.isEnabled = total.text?.isEmpty == false
    }
    
    private func setTextFieldsDelegates() {
        recordName.delegate = self
        total.delegate = self
        weight.delegate = self
        count.delegate = self
    }
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        total.inputAccessoryView = doneToolbar
        weight.inputAccessoryView = doneToolbar
        count.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction(sender: UITextField) {
        total.resignFirstResponder()
        weight.resignFirstResponder()
        count.resignFirstResponder()
    }
    
}
