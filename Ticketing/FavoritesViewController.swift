//
//  FavoritesViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {

    struct favorite {
          var name: String
          var time: String
          var location: String
          //var img: UIImage
      }
    
    var favorites = [favorite(name: "Green Day", time: "Oct. 31, 2019 - 7:00PM", location: "American Airlines Arena"),
                     favorite(name: "Fall Out Boy", time: "Dec. 12, 2019 - 8:00PM", location: "American Airlines Arena"),
                     favorite(name: "Panic! At The Disco", time: "Jan. 21, 2020 - 9:00PM", location: "BB&T Center"),
                     favorite(name: "Jeff Dunham", time: " Jan. 24, 2020 - 7:30PM", location: "American Airlines Arena"),
                     favorite(name: "granson", time: "Mar. 20, 2020 - 7:00PM", location: "BB&T Center")]
    
    
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
        let newFavorite = favorites[indexPath.row]
        cell.eventlabel.text = newFavorite.name
        cell.timelabel.text = newFavorite.time
        cell.locationlabel.text = newFavorite.location
        cell.img.image = #imageLiteral(resourceName: "green day")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            print("Finished removing cell \(indexPath)")
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}

    
  

