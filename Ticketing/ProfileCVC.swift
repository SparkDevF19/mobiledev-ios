//
//  ProfileCVC.swift
//  Ticketing
//
//  Created by Jose Bello on 10/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ProfileCVC: UIViewController {
    
    //Reference to text fields
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var errorFNameLable: UILabel!
    @IBOutlet weak var errorLNameLable: UILabel!
    @IBOutlet weak var errorEmailLable: UILabel!
    @IBOutlet weak var errorPWLable: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Error messages for incorrext textField input
        errorFNameLable.isHidden = true
        errorLNameLable.isHidden = true
        errorEmailLable.isHidden = true
        errorPWLable.isHidden = true
        
        saveButton.layer.cornerRadius = 25.0
        
        fNameTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        lNameTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        pwTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        pwTextField.isSecureTextEntry = true
    }
    
    @objc func txtFieldChanged(_ sender: UITextField) {
        guard let input = sender.text else { return }
    }
   
    //Save all the updates to the profile
    @IBAction func saveButton(_ sender: UIButton) {
        if(fNameTextField.txtFieldsValidation(type: .name) == false || lNameTextField.txtFieldsValidation(type: .name) == false) {
            if(fNameTextField.txtFieldsValidation(type: .name) == false) {
                errorFNameLable.isHidden = false
            }
            if(lNameTextField.txtFieldsValidation(type: .name) == false) {
                errorLNameLable.isHidden = false
            }
        }
        else {
            errorFNameLable.isHidden = true
            errorLNameLable.isHidden = true
            FirebaseAPI.shared.updateName(fNameTextField.text, lNameTextField.text) {
                
            }
        }
        if(emailTextField.txtFieldsValidation(type: .email) == false) {
            errorEmailLable.isHidden = false
        }
        else {
            errorEmailLable.isHidden = true
            FirebaseAPI.shared.updateEmail(emailTextField.text) {
                
            }
        }
        if(pwTextField.txtFieldsValidation(type: .password) == false) {
            errorPWLable.isHidden = false
        }
        else {
            errorPWLable.isHidden = true
            FirebaseAPI.shared.updatePassword(pwTextField.text) {
                
            }
        }
    }
}

//MARK: Extension
extension UITextField {
    enum txtFieldValidate {
        case name;
        case email;
        case password;
    }
    
    func txtFieldsValidation(type: txtFieldValidate)->Bool {
        switch txtFieldValidate {
        case txtFieldValidate.name:
            return nameValidator();
        case txtFieldValidate.email:
            return emailValidation()
        case txtFieldValidate.password:
            return passwordValidation();
        }
    }
    
    private func nameValidator()->Bool {
        if let text = text {
            if(text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
                return false
            }
            else if(text.count > 16) {
                return false
            }
            else {
                return true
            }
        }
    }
    
    private func emailValidation()->Bool {
        if let text = text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                return false
        }
        else {
            return true
        }
    }
    
    private func passwordValidation()->Bool {
        if let text = text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                return false
        }
        else {
            return true
        }
    }
}
