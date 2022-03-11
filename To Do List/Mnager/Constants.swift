//
//  Constants.swift
//  To Do List
//
//  Created by Mac on 1/18/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import Foundation

struct StoryBoard {
    static let main = "Main"
    static let signUpVC = "SignUpVC"
    static let singinVC = "SignInVC"
    static let mainVC = "MainVC"
    static let AddNoteVC = "AddNoteVC"
    static let cellID = "NoteCell"
    static let isLoggedIn = "isLoggedIn"
}

struct FireStore {
    static let collectionName = "note"
    static let dateField = "date"
    static let noteField = "note"
    static let senderField = "sender"
    static let fbString = "Error signing out: %@"
}

struct Constant {
    static let user = "user"
    static let email = "email"
    static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let emailRegexPredic = "SELF MATCHES %@"
    static let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let passwordRegexPredic = "SELF MATCHES %@"
}
