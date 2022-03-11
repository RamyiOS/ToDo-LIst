//
//  MainVC.swift
//  To Do List
//
//  Created by Mac on 1/2/22.
//  Copyright © 2022 ramy. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn(value: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    private func isLoggedIn(value: Bool) {
        let def = UserDefaults.standard
        def.set(false, forKey: StoryBoard.isLoggedIn)
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
    
    private func validFields() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            UserDefaultManager.shared().setUserEmail(email: email)
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.goToMainScreen()
                }
            }
        }
    }
    
    private func goToSignUpScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let signUpVC = sb.instantiateViewController(withIdentifier: StoryBoard.signUpVC) as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    private func goToMainScreen() {
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let mainVC = sb.instantiateViewController(withIdentifier: StoryBoard.mainVC) as! MainVC
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        validFields()
    }
    
    @IBAction func orSignUpBtnTapped(_ sender: UIButton) {
        goToSignUpScreen()
    }
}

