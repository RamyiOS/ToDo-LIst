//
//  UserDefaultsManager.swift
//  To Do List
//
//  Created by Mac on 1/26/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import Foundation

class UserDefaultManager {
    
    let def = UserDefaults.standard
    static let sharedInstance = UserDefaultManager()
    
    static func shared() -> UserDefaultManager {
        return UserDefaultManager.sharedInstance
    }
    
    func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user){
            def.set(encodedUser, forKey: Constant.user)
        }
    }
    
    func loadUserData() -> User? {
        if let savedUser = def.object(forKey: Constant.user) as? Data {
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(User.self, from: savedUser) {
                return decodedUser
            }
        }
        return nil
    }
    
    func setIsLoggedIn(value: Bool) {
        def.set(value, forKey: StoryBoard.isLoggedIn)
    }
    
    func getUserEmail() -> String? {
        if let email = def.string(forKey: Constant.email) {
            return email
        }
        return nil
    }
    
    func setUserEmail(email: String) {
        def.set(email, forKey: Constant.email)
    }
}
