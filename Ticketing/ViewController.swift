//
//  ViewController.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 9/24/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Reference to First Name test field
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add the acction for the text field
        firstNameTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
    }
    //Acction for when the text field changes
    @objc func handleTextFieldChanged(_ sender: UITextField) {
    
    guard let input = sender.text else { return }
        
        print("\(input)")
    }
}

