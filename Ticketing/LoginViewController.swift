//
//  LoginViewController.swift
//  Ticketing
//
//  Created by Reiner Gonzalez on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func googleSignInTapped(_ sender: Any) {
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
    }
    
}
