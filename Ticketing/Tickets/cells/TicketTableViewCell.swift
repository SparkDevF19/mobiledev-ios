//
//  TicketTableViewCell.swift
//  Ticketing
//
//  Created by Maia Duschatzky on 10/22/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var ticketInfo: UILabel!
    @IBOutlet weak var ticketName: UILabel!
    @IBOutlet weak var ticketPic: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
