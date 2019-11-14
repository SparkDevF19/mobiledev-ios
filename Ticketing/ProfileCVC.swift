//
//  ProfileCVC.swift
//  Ticketing
//
//  Created by Jose Bello on 10/8/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ProfileCVC: UIViewController{
    
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fNameTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        lNameTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        pwTextField.addTarget(self, action: #selector(txtFieldChanged), for: .editingDidEnd)
        pwTextField.isSecureTextEntry = true
    }
    
    @objc func txtFieldChanged(_ sender: UITextField) {
        guard let input =  sender.text else { return }
        
        print("\(input)")   // <-- ERASE
    }
   
    @IBAction func saveButton(_ sender: UIButton) {
        
    }
}
