//
//  LoginViewController.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 6/6/17.
//  Copyright © 2017 Freddy Hernandez. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let email = usernameTextField.text, let password = passwordTextField.text {
            guard email != "" && password != "" else {
                print("empty string email and password")
                self.errorLabel.isHidden = false
                errorLabel.text = "type a username or password"
                return
            }
            
            print("attempting to auth")
            Auth.auth().signIn(withEmail: email, password: password) {
                (user, error) in
                
                if user != nil {
                    print("yay")
                    self.errorLabel.isHidden = true
                }
                
            }
        } else {
            print("not yay")
            self.errorLabel.isHidden = false
            errorLabel.text = "type a username or password"
        }
    }
    

}
