//
//  signInVC.swift
//  To Do List
//
//  Created by Mac on 1/2/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    private func isValidName(name: String) -> Bool {
        if !name.isEmpty {
            return true
        } else {
            showAlert(message: "Please enter user name!")
            return false
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        if !email.trimmed.isEmpty {
            if Validator.shared().isValidEmail(email: email) {
                return true
            } else {
                showAlert(message: "Please enter valid email")
                return false
            }
        } else {
            showAlert(message: "Please enter email")
        }
        return false
    }
    
    private func isValidPassword(password: String) -> Bool {
        if !password.isEmpty {
            if Validator.shared().isValidPasseord(password: password) {
                return true
            } else {
                showAlert(message: "Please enter valid password with 8 characters at least 1 Alphabet and 1 Number:")
                return false
            }
        } else {
            showAlert(message: "Please enter valid password")
            return false
        }
    }
    
    private func validFields() -> Bool {
        if let email = emailTextField.text, isValidEmail(email: email),
            let password = passwordTextField.text, isValidPassword(password: password) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if self.user != nil {
                    UserDefaultManager.shared().saveUser(user: self.user)
                }
            }
            return true
        }
        return false
    }
    
    private func goToMainScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let mainVc = sb.instantiateViewController(identifier: StoryBoard.mainVC) as! MainVC
        self.navigationController?.pushViewController(mainVc, animated: true)
    }
    
    private func goToSigninScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signinVC = sb.instantiateViewController(withIdentifier: StoryBoard.singinVC) as! SignInVC
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        if validFields() {
            goToSigninScreen()
        } else {
            showAlert(message: "Please check your information again!")
        }
    }
    @IBAction func orSinginBtnTapped(_ sender: UIButton) {
        goToSigninScreen()
    }
}
