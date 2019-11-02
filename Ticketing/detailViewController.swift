//
//  detailViewController.swift
//  Ticketing
//
//  Created by Ung Hour on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import MapKit

class detailViewController: UIViewController {
    
    struct CellIdentifiers {
        static let eventDetailCell = "EventGeneralDetailsTableViewCell"
        static let descriptionCell = "DescriptionTableViewCell"
        static let locationCell    = "LocationTableViewCell"
        
    }
    
    struct CellNibNames {
        static let eventDetailCell = "EventGeneralDetailsTableViewCell"
        static let descriptionCell = "DescriptionTableViewCell"
        static let locationCell    = "LocationTableViewCell"

    }
 
    @IBOutlet weak var detailTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //let nibCell = UINib(nibName: cell, bundle: nil)
        configureTableView()
        setupHeader()
    }
    
    func configureTableView() {
        detailTableView.register(UINib.init(nibName: CellNibNames.eventDetailCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.eventDetailCell)
        detailTableView.register(UINib.init(nibName: CellNibNames.descriptionCell, bundle: nil),forCellReuseIdentifier: CellIdentifiers.descriptionCell)
        detailTableView.reloadData()
        detailTableView.register(UINib.init(nibName: CellNibNames.locationCell, bundle: nil),forCellReuseIdentifier: CellIdentifiers.locationCell)
        detailTableView.reloadData()
    }
    
    func setupHeader() {
        let headerNib = UINib(nibName: "EventImageHeaderView", bundle: nil)
        detailTableView.tableHeaderView = 
    }
}


extension detailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.eventDetailCell, for: indexPath) as! EventGeneralDetailsTableViewCell

        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.eventDetailCell, for: indexPath) as! EventGeneralDetailsTableViewCell
            cell.title.text = "MIA"
            cell.detail.text = "Name"
            cell.label.text = "01/01/2020"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.descriptionCell, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionLabel.text = "Description"
            cell.artistDetail.text = "Details About the Singer"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.locationCell, for: indexPath) as! LocationTableViewCell
            cell.location.text = "Testing"
            let location = CLLocationCoordinate2D(latitude: 25.761681, longitude: -80.191788)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            cell.map.setRegion(region, animated: true)
            return cell
        }
     
        
    
   
    }
    

}

