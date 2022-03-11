//
//  AddNoteVC.swift
//  To Do List
//
//  Created by Mac on 1/20/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import UIKit
import Firebase

class AddNoteVC: UIViewController {
    
    @IBOutlet weak var DateTitleLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    let db = Firestore.firestore()
    let dataPicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView()
    }
    
    private func datePickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let barBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnTapped))
        toolBar.setItems([barBtn], animated: true)
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = dataPicker
    }
    
    @objc func doneBtnTapped() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        dateTextField.text = formatter.string(from: dataPicker.date)
        self.view.endEditing(true)
    }
    
    private func goToMainScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveNote() {
        if let noteBody = noteTextField.text, let dateBody = dateTextField.text, let user = Auth.auth().currentUser?.email {
            db.collection(FireStore.collectionName).addDocument(data: [FireStore.senderField: user, FireStore.dateField: dateBody, FireStore.noteField: noteBody]) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.goToMainScreen()
                }
            }
        }
    }

    
    @IBAction func saveNoteBtnTapped(_ sender: UIButton) {
        saveNote()
    }
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        goToMainScreen()
    }
}
