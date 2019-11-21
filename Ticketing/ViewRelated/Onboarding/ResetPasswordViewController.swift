//
//  ResetPasswordViewController.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/15/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButtonLabel: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        StyleFields.styleTextField(emailTextField)
        StyleFields.styleButtonColor(sendButtonLabel)
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.alpha = 0
        errorLabel.text = "Send"
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        FirebaseAPI.shared.forgotPassword(to: emailTextField.text!) { (error) in
            if let error = error{
                print("error")
                self.errorLabel.alpha = 1
                self.errorLabel.text = "Invalid email"
                self.errorLabel.errorShake()
                return
            }
            self.sendButtonLabel.setTitle("Email sent", for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if fieldValidation(textField: emailTextField){
            textField.resignFirstResponder()
        }
        else{
            emailTextField.errorShake()
        }
        return true
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        emailTextField.resignFirstResponder()
    }
}

func fieldValidation(textField: UITextField) -> Bool{
       if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
           return false
       }
       return true
   }

