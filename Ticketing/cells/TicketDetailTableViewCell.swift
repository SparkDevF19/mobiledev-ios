//
//  TicketDetailTableViewCell.swift
//  Ticketing
//
//  Created by Maia Duschatzky on 11/18/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TicketDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var sectionNumber: UILabel!
    @IBOutlet weak var rowNumber: UILabel!
    @IBOutlet weak var seatNumber: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
