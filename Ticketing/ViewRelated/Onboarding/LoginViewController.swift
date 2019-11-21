//
//  LoginViewController.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var googleSignInLabel: UIButton!
    @IBOutlet weak var signInLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        styleFields()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Do any additional setup after loading the view.
    }
    @IBAction func googleSignInTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error")
            return
        }
        
        FirebaseAPI.shared.loginUser(withGoogle: signIn, didSignInFor: user) { (error, results) in
            if let error = error {
                print(error)
                return
            }
            
            if let results = results{
                print("success")
                self.performSegue(withIdentifier: "homeScreenSegue", sender: self)
            }
        }
    }
    
    //Sign in button action
    @IBAction func signInTapped(_ sender: Any) {
        //if statement checking that both text fields were filled in
        if !fieldValidation(textField: emailTextField) || !fieldValidation(textField: passwordTextField){
            print("Empty fields error")
            self.errorLabel.text = "Fill in both fields"
            self.errorLabel.alpha = 1
            self.errorLabel.errorShake()
            return
        }
        
        //loginuser function call
        FirebaseAPI.shared.loginUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (error, user) in

            if let error = error as NSError? {

            guard let errorCode = AuthErrorCode(rawValue: error.code) else {

                print("there was an error logging in but it could not be matched with a firebase code")
                self.errorLabel.text = "Error signing in"
                self.errorLabel.alpha = 1
                self.errorLabel.errorShake()
                return

            }
                //switch statement checking for specific error returned
                switch errorCode{
                case .invalidEmail:
                    print("invalid email")
                    self.errorLabel.text = "Invalid email"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                case .wrongPassword:
                    print("invalid password")
                    self.errorLabel.text = "Invalid password"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                default:
                    print(error)
                    print("invalid field")
                    self.errorLabel.text = "Invalid field"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                }
                return
            }
            
            //segue to home screen if login was completed
            if let user = user {
                print("success")
                self.performSegue(withIdentifier: "homeScreenSegue", sender: self)
            }
        }
    }
    
    //removing the error label when new textfield is touched
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.alpha = 0
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //switch statement checking that each field has been filled in before changing first responder
        switch textField{
        case emailTextField:
            if(fieldValidation(textField: emailTextField)){
                passwordTextField.becomeFirstResponder()
            }
            else{
                emailTextField.errorShake()
            }
        case passwordTextField:
            if(fieldValidation(textField: passwordTextField)){
                passwordTextField.resignFirstResponder()
            }
            else{
                passwordTextField.errorShake()
            }
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    //dismissing keyboard on background tap
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

extension LoginViewController{
    func styleFields(){
        //styling text fields
        StyleFields.styleTextField(emailTextField)
        StyleFields.styleTextField(passwordTextField)
        
        //styling buttons
        StyleFields.styleButtonColor(googleSignInLabel)
        StyleFields.styleButtonColor(signInLabel)
    }
    
    func fieldValidation(textField: UITextField) -> Bool{
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
}
