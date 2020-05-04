//
//  NewRecordViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit
import RealmSwift

final class NewRecordViewController: UITableViewController {

    // MARK: - Public Properties
    var selectedCategory: Category! {
        didSet { categoryName.text = selectedCategory.name }
    }
    
    var record: Record?
    
    // MARK: - IBOutlets
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var recordImage: UIImageView!
    @IBOutlet var recordTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var recordName: UITextField!
    @IBOutlet var totalTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var countTextField: UITextField!
    @IBOutlet var commentaryTextField: UITextField!
    @IBOutlet var recordDatePicker: UIDatePicker!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        setTextFieldsDelegates()
        addDoneButtonOnKeyboard()
        addListeners()
        
        setupEditScreen()
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            addPhoto()
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Public Methods
    func saveRecord() {
        guard let totalString = totalTextField.text, let total = Double(totalString)
            else { return }
        
        let selectedSegmentIndex = recordTypeSegmentedControl.selectedSegmentIndex
        
        let newRecord = Record(
            name: recordName.text,
            total: total,
            isIncomeType: selectedSegmentIndex == CategoryType.income.rawValue,
            weight: Double(weightTextField.text ?? ""),
            count: Int(countTextField.text ?? ""),
            commentary: commentaryTextField.text,
            imageData: recordImage.image?.pngData(),
            date: recordDatePicker.date,
            selectedCategory: selectedCategory
        )
        
        if let record = record {
            try! realm.write {
                record.name = newRecord.name
                record.total = newRecord.total
                record.weight.value = newRecord.weight.value
                record.count.value = newRecord.count.value
                record.commentary = newRecord.commentary
                record.imageData = newRecord.imageData
                record.date = newRecord.date
                record.selectedCategory = newRecord.selectedCategory
            }
        } else {
            storageManager.saveRecords([newRecord])
        }
        
    }
    
    // MARK: - Private Methods
    @objc private func segmentedControlValueChanged() {
        var category: Category?
        
        switch recordTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            category = realm.objects(Category.self).filter("type == %@",
                                                           CategoryType.expense.rawValue).first
        case 1:
            category = realm.objects(Category.self).filter("type == %@",
                                                           CategoryType.income.rawValue).first
        default:
            break
        }
        
        selectedCategory = category
    }
    
    private func addListeners() {
        totalTextField.addTarget(self,
                                 action: #selector(textFieldDidChanged),
                                 for: .editingChanged)
        
        recordTypeSegmentedControl.addTarget(self,
                                             action: #selector(segmentedControlValueChanged),
                                             for: .valueChanged)
        if selectedCategory == nil {
            segmentedControlValueChanged()
        }
    }
    
    private func setupEditScreen() {
        guard let record = record else { return }
        
        setupNavigationBar()
        
        guard let imageData = record.imageData, let image = UIImage(data: imageData) else {
            return
        }
        
        recordImage.image = image
        recordImage.contentMode = .scaleAspectFill
        recordTypeSegmentedControl.selectedSegmentIndex = record.isIncomeType ? 1 : 0
        recordTypeSegmentedControl.isEnabled = false
        selectedCategory = record.selectedCategory
        recordName.text = record.name
        totalTextField.text = String(record.total)
        
        if let weight = record.weight.value {
            weightTextField.text = String(weight)
        }
        if let count = record.count.value {
            countTextField.text = String(count)
        }
        commentaryTextField.text = record.commentary
        recordDatePicker.date = record.date
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        title = record?.name ?? "Без названия"
        navigationItem.leftBarButtonItem = nil
        saveButton.isEnabled = true
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
        saveButton.isEnabled = totalTextField.text?.isEmpty == false
    }
    
    private func setTextFieldsDelegates() {
        recordName.delegate = self
        totalTextField.delegate = self
        weightTextField.delegate = self
        countTextField.delegate = self
    }
    
    private func addDoneButtonOnKeyboard() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: UIScreen.main.bounds.width,
                           height: 50)
        let doneToolbar: UIToolbar = UIToolbar(frame: frame)
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        totalTextField.inputAccessoryView = doneToolbar
        weightTextField.inputAccessoryView = doneToolbar
        countTextField.inputAccessoryView = doneToolbar
    }

    @objc private func doneButtonAction(sender: UITextField) {
        totalTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        countTextField.resignFirstResponder()
    }
    
}

// MARK: Navigation
extension NewRecordViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCategory" {
            let categoryVC = segue.destination as! CategoryViewController
            categoryVC.categoryType = CategoryType(rawValue: recordTypeSegmentedControl.selectedSegmentIndex)
            categoryVC.selectedCategory = selectedCategory
        }
    }
    
    @IBAction func unwindFromCategoryVC(_ sender: UIStoryboardSegue) { }
    
}

// MARK: Work with image
extension NewRecordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        recordImage.image = info[.editedImage] as? UIImage
        recordImage.contentMode = .scaleAspectFill
        recordImage.clipsToBounds = true
        
        dismiss(animated: true)
    }
    
    private func addPhoto() {
        let cameraIcon = UIImage(named: "camera")
        let photoIcon = UIImage(named: "photoLibrary")
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Камера", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Библиотека", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
}
