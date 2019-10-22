//
//  FavoritesTableViewCell.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var eventlabel: UILabel!
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    
}
