//
//  SignUpVC.swift
//  To Do List
//
//  Created by Mac on 1/2/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import UIKit
import Firebase

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let db = Firestore.firestore()
    var notes: [Note] = []
    var user: User!
    var email = UserDefaultManager.shared().getUserEmail()
    var noteBody: Note!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        isLoggedIn(value: true)
        loadNote()
        registerCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    
    private func isLoggedIn(value: Bool) {
        let def = UserDefaults.standard
        def.set(true, forKey: StoryBoard.isLoggedIn)
    }
    
    private func logOut() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.openOnSignInScreen()
        }
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: StoryBoard.cellID, bundle: nil), forCellReuseIdentifier: StoryBoard.cellID)
    }
    
    private func loadNote() {
        db.collection(FireStore.collectionName).addSnapshotListener { (querySnapshot, error) in
            self.notes = []
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let documents = querySnapshot?.documents {
                    for doc in documents {
                        let data = doc.data()
                        if let sender = data[FireStore.senderField] as? String, let date = data[FireStore.dateField] as? String, let note = data[FireStore.noteField] as? String, let id = doc.documentID as? String {
                            if sender == self.email{
                                let note = Note(date: date, note: note, id: id)
                                self.noteBody = note
                                self.notes.append(note)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteNote() {
        if let sender = self.email {
            if noteBody != nil {
                self.db.collection(FireStore.collectionName).document(noteBody.id!).delete()
                    { err in
                        if let err = err {
                            print("Error removing document: \(err.localizedDescription)")
                        } else {
                            print("Document successfully removed!")
                        }
                }
            }
        }
    }
    
    @IBAction func addNoteBtnTapped(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let addNoteVC = sb.instantiateViewController(identifier: StoryBoard.AddNoteVC) as! AddNoteVC
        self.present(addNoteVC, animated: true, completion: nil)
    }
    
    private func logOutTapped() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.logOut()
        } catch let signOutError as NSError {
            print(FireStore.fbString, signOutError)
        }
    }
    
    @IBAction func logOutBtnTapped(_ sender: UIBarButtonItem) {
        logOutTapped()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.cellID, for: indexPath) as! NoteCell
        cell.dateLabel.text = notes[indexPath.row].date
        cell.noteLabel.text = notes[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            deleteNote()
            tableView.deleteRows(at: [indexPath], with: .fade)
            notes.remove(at: indexPath.row)
            tableView.endUpdates()
        }
    }
}
