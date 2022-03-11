//
//  Validator.swift
//  To Do List
//
//  Created by Mac on 1/26/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import Foundation

class Validator {
    
    // singlton
    private static let sharedInstance = Validator()
    
    static func shared() -> Validator {
        return Validator.sharedInstance
    }
    
    // regex validation
    func isValidEmail(email: String) -> Bool {
        let regex = Constant.emailRegex
        let predic = NSPredicate(format: Constant.emailRegexPredic, regex)
        let result = predic.evaluate(with: email)
        return result
    }
    
    func isValidPasseord(password: String) -> Bool {
        let regex = Constant.passwordRegex
        let predic = NSPredicate(format: Constant.passwordRegexPredic, regex)
        let result = predic.evaluate(with: password)
        return result
    }
}
