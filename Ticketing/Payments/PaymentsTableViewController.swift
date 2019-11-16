//
//  FavoritesViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class PaymentsTableViewController: UITableViewController {

    struct payment {
          var name: String
          var number: String
          //var img: UIImage
      }
    
    var favorites = [payment(name: "AMEX", number: "**** 1454",
                     payment(name: "Visa", number: "**** 4738"),
                     payment(name: "MasterCard", number: "**** 2383"),]
    
    
    struct CellIdentifier {
        static let PaymentsCell = "PaymentsTableViewCell"
    }
    
    struct CellNibNames {
        static let PaymentsCell = "PaymentsTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let paymentsNib = UINib(nibName: CellIdentifier.PaymentsCell, bundle: nil)
        tableView.register(paymentsNib, forCellReuseIdentifier: "PaymentsTableViewCell")
        
    }
    
}


extension PaymentsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentsTableViewCell", for: indexPath) as! PaymentsTableViewCell
        let newPayment = Payments[indexPath.row]
        cell.paymentlabel.text = newPayment.name
        cell.numberlabel.text = newPayment.number
        cell.img.image = #imageLiteral(resourceName: "amex")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            self.payments.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
            
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

    
  

