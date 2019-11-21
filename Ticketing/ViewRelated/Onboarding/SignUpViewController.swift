//
//  SignUpViewController.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleFields()
        errorLabel.alpha = 0
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //if statement checking that both text fields were filled in
        if !fieldValidation(textField: emailTextField) || !fieldValidation(textField: passwordTextField) ||
            !fieldValidation(textField: confirmPasswordTextField) || !fieldValidation(textField: firstNameTextField) ||
            !fieldValidation(textField: lastNameTextField){
            
            print("Empty fields error")
            self.errorLabel.text = "Please fill in all fields"
            self.errorLabel.alpha = 1
            self.errorLabel.errorShake()
            return
        }
        
        if !confirmPassword(pass: passwordTextField.text!, confirmpw: confirmPasswordTextField.text!){
            print("Passwords don't match")
            self.errorLabel.text = "Passwords don't match"
            self.errorLabel.numberOfLines = 0
            self.errorLabel.alpha = 1
            self.errorLabel.errorShake()
            return
        }
        
        FirebaseAPI.shared.registerUser(email: emailTextField.text!, password: passwordTextField.text!) { (error, user) in
            
            if let error = error as NSError? {

            guard let errorCode = AuthErrorCode(rawValue: error.code) else {

                print("there was an error logging in but it could not be matched with a firebase code")
                self.errorLabel.text = "Error registering"
                self.errorLabel.alpha = 1
                self.errorLabel.errorShake()
                return

            }
                switch errorCode{
                case .invalidEmail:
                    print("invalid email error")
                    self.errorLabel.text = "Invalid email"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                case .emailAlreadyInUse:
                    print("Email already in use")
                    self.errorLabel.text = "Email already in use"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                case .weakPassword:
                    print("Weak password error")
                    self.errorLabel.text = "Weak password"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                default:
                    print(error)
                    print("default switch case error")
                    self.errorLabel.text = "Error registering"
                    self.errorLabel.alpha = 1
                    self.errorLabel.errorShake()
                }
                return
            }
            
            FirebaseAPI.shared.updateName(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!) { (error) in
            if let error = error {
                print(error)
                print("Update name error")
                self.errorLabel.text = "Invalid name field"
                self.errorLabel.alpha = 1
                self.errorLabel.errorShake()
                return
            }
            
            if let user = user{
                self.performSegue(withIdentifier: "segueFromSignUp", sender: self)
            }
            
        }
    }
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.alpha = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case emailTextField:
            if (fieldValidation(textField: emailTextField)){
                passwordTextField.becomeFirstResponder()
            }
            else {
                emailTextField.errorShake()
            }
        case passwordTextField:
           if (fieldValidation(textField: passwordTextField)){
                confirmPasswordTextField.becomeFirstResponder()
            }
            else {
                passwordTextField.errorShake()
            }
        case confirmPasswordTextField:
            if (fieldValidation(textField: confirmPasswordTextField)){
                firstNameTextField.becomeFirstResponder()
            }
            else {
                confirmPasswordTextField.errorShake()
            }
        case firstNameTextField:
            if (fieldValidation(textField: firstNameTextField)){
                lastNameTextField.becomeFirstResponder()
            }
            else {
                firstNameTextField.errorShake()
            }
        case lastNameTextField:
            if (fieldValidation(textField: lastNameTextField)){
                lastNameTextField.resignFirstResponder()
            }
            else {
                lastNameTextField.errorShake()
            }
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dismissOnGesture()
    }
    
}


extension SignUpViewController {
    func dismissOnGesture(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }
    
    func styleFields(){
            //styling text fields
            StyleFields.styleTextField(emailTextField)
            StyleFields.styleTextField(passwordTextField)
            StyleFields.styleTextField(confirmPasswordTextField)
            StyleFields.styleTextField(firstNameTextField)
            StyleFields.styleTextField(lastNameTextField)
            
            //styling buttons
            StyleFields.styleButtonColor(signUpButtonLabel)
    }
    
    func fieldValidation(textField: UITextField) -> Bool{
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
    func confirmPassword(pass: String, confirmpw: String) -> Bool{
        if pass != confirmpw{
            return false
        }
        else{
            return true
        }
    }
    
    func fieldValidation(field: UITextField) -> Bool{
        if field.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    
}

