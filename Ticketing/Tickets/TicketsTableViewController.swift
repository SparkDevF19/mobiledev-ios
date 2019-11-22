//
//  TicketsTableViewController.swift
//  Ticketing
//
//  Created by Maia Duschatzky on 10/22/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TicketsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var sections = ["Upcoming", "Past"]
    
    
    var ticketData: [Ticket] = [Ticket(id: 1, name: "Ariana Grande", desc: "Concert")]

    override func viewDidLoad() {
        super.viewDidLoad()
        let ticketNib = UINib(nibName: "TicketTableViewCell", bundle: nil)
        tableView.register(ticketNib, forCellReuseIdentifier: "TicketTableViewCell")
        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ticketData.count
    }//check date then check amount of rows based on date. if old then put in past section

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTableViewCell", for: indexPath) as! TicketTableViewCell
        // Configure the cell...
        let ticket = ticketData[indexPath.row]//just looking at rows
        cell.ticketName.text = ticket.name //name of ticket goes to label
        cell.ticketInfo.text = ticket.desc

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
