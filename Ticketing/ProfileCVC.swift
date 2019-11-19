//
//  ProfileCVC.swift
//  Ticketing
//
//  Created by Jose Bello on 10/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

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
        IQKeyboardManager.shared.enable = true
        //Checking if is a google log in
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                if  userInfo.providerID == GoogleAuthProviderID {
                    emailTextField.isUserInteractionEnabled = false
                    pwTextField.isUserInteractionEnabled = false
                }
            }
        }
        emailTextField.isUserInteractionEnabled = true
        pwTextField.isUserInteractionEnabled = true
        
        //Error messages for incorrext textField input
        errorFNameLable.isHidden = true
        errorLNameLable.isHidden = true
        errorEmailLable.isHidden = true
        errorPWLable.isHidden = true
        
        saveButton.layer.cornerRadius = 20.0
        pwTextField.isSecureTextEntry = true
    }
   
    //MARK: Save Button
    @IBAction func saveButton(_ sender: UIButton) {
        
        var update = true
        
        //update name
        if(fNameTextField.txtFieldsValidation(type: .name)) {
            errorFNameLable.isHidden = true
        }
        else {
            update = false
            errorFNameLable.isHidden = false
        }
        
        if(lNameTextField.txtFieldsValidation(type: .name)) {
            errorLNameLable.isHidden = true
        }
        else {
            update = false
            errorLNameLable.isHidden = false
        }
        
        if(update) {
            FirebaseAPI.shared.updateName(firstName: fNameTextField.text!, lastName: lNameTextField.text!) {
                    error in
                    if let error = error {
                        print(error)
                }
            }
        }
        
        //update email
        if(!emailTextField.txtFieldsValidation(type: .email)) {
            errorEmailLable.isHidden = false
        }
        else {
            errorEmailLable.isHidden = true
            FirebaseAPI.shared.updateEmail(to: emailTextField.text!) {
                error in
                if let error = error {
                    print(error)
                }
            }
        }
        
        //update password
        if(!pwTextField.txtFieldsValidation(type: .password)) {
            errorPWLable.isHidden = false
        }
        else {
            errorPWLable.isHidden = true
            FirebaseAPI.shared.updatePassword(to: pwTextField.text!) {
                error in
                if let error = error {
                    print(error)
                }
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
        switch type {
        case .name:
            return nameValidation();
        case .email:
            return emailValidation()
        case .password:
            return passwordValidation();
        }
    }
    
    private func nameValidation()->Bool {
        if let text = text {
            if(text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
                return false
            }
            else if(text.count > 16) {
                return false
            }
            return true
        }
        return false
    }
    
    private func emailValidation()->Bool {
        if let text = text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                return false
        }
        return true
    }
    
    private func passwordValidation()->Bool {
        if let text = text, text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
                return false
        }
        return true
    }
}
