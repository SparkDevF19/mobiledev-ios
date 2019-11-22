//
//  TableCellTableViewCell.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/16/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var nameLbl: UIView!
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
