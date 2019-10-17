//
//  FavoritesViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {

    var favorites = ["Green Day", "FallOut Boy", "Panic! At the Disco", "Jeff Dunham", "grandson"]
    
    struct CellIdentifier {
        static let FavoritesCell = "FavoritesTableViewCell"
    }
    
    struct CellNibNames {
        static let FavoritesCell = "FavoritesTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let favoritesNib = UINib(nibName: CellIdentifier.FavoritesCell, bundle: nil)
        tableView.register(favoritesNib, forCellReuseIdentifier: "FavoritesTableViewCell")
        
    }
    
}


extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.favoritesTableViewCell.text = favorites[indexPath.row]
        return cell
    }
    
    
}
