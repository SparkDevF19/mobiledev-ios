//
//  SignUpViewController.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

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
}

