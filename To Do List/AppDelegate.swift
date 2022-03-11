//
//  AppDelegate.swift
//  To Do List
//
//  Created by Mac on 1/2/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        handleRootVC()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }
    
    private func handleRootVC() {
        let def = UserDefaults.standard
        if let isLoggedIn = def.object(forKey: StoryBoard.isLoggedIn) as? Bool {
            if isLoggedIn {
                self.openOnMainScreen()
            } else {
                self.openOnSignInScreen()
            }
        }
    }
    
    func openOnSignInScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signInVC = sb.instantiateViewController(withIdentifier: StoryBoard.singinVC) as! SignInVC
        let navController = UINavigationController(rootViewController: signInVC)
        self.window?.rootViewController = navController
    }
    
    func openOnMainScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let mainVC = sb.instantiateViewController(withIdentifier: StoryBoard.mainVC) as! MainVC
        let navController = UINavigationController(rootViewController: mainVC)
        self.window?.rootViewController = navController
    }
}


