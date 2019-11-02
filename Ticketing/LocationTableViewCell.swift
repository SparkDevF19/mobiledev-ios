//
//  LocationTableViewCell.swift
//  Ticketing
//
//  Created by Ung Hour on 10/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import MapKit

class LocationTableViewCell: UITableViewCell {
    

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var map: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
