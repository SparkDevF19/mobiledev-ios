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
    @IBOutlet weak var buyButtonFeature: UIButton!
    @IBOutlet weak var priceLable: UILabel!
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
    }
    @IBAction func buyButton(_ sender: UIButton){
        
    }
    
    override func viewDidLoad() {
        buyButtonFeature.layer.cornerRadius = buyButtonFeature.bounds.size.height / 2.0
        super.viewDidLoad()
        
        detailTableView.tableFooterView = UIView()
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
        let headerNib = UINib.init(nibName: "EventImageHeaderView", bundle: Bundle.main)
        
        let headerView = headerNib.instantiate(withOwner: nil, options: nil)[0] as! EventImageHeaderView
        headerView.headerImage.image = #imageLiteral(resourceName: "AOSMYG3AUJA3FAGQMQQ266O6OY")
        detailTableView.tableHeaderView = headerView
       
    }
}


extension detailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.eventDetailCell, for: indexPath) as! EventGeneralDetailsTableViewCell
            cell.title.text  = "MIA"
            cell.detail.text = "Name"
            cell.label.text  = "01/01/2020"
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.descriptionCell, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionLabel.text = "Description"
            cell.artistDetail.text = "Details About the Singer"
            cell.selectionStyle = .none
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.locationCell, for: indexPath) as! LocationTableViewCell
            cell.location.text = "Location"
            let location = CLLocationCoordinate2D(latitude: 25.761681, longitude: -80.191788)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            cell.map.setRegion(region, animated: true)
            cell.selectionStyle = .none
            return cell
        }
   }
    
}


