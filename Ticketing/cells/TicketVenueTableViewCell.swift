//
//  TicketVenueTableViewCell.swift
//  Ticketing
//
//  Created by Maia Duschatzky on 11/18/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TicketVenueTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var venueInfo: UILabel!
    @IBOutlet weak var dateInfo: UILabel!
    @IBOutlet weak var timeInfo: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
