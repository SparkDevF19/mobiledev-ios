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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StyleFields.styleTextField(emailTextField)
        StyleFields.styleButtonColor(sendButtonLabel)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendTapped(_ sender: Any) {
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

