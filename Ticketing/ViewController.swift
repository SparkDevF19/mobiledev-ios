//
//  ViewController.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 9/24/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TicketmasterAPI.getSuggested(latitude: 25.7959, longitude: 80.2871) { result in
            switch result {
            case .success(let suggest):
                print(suggest)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

