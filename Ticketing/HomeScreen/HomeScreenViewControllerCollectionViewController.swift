//
//  HomeScreenViewControllerCollectionViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/15/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeScreenViewControllerCollectionViewController: UICollectionViewController {
    
    let LocalEventsCollectionViewCellId = "LocalEventsCollectionViewCell"
    
    var products = [LocalEventsData]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()


        // Register cell classes
        
        let nibCell = UINib(nibName: LocalEventsCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: LocalEventsCollectionViewCellId)
        
        collectionView.reloadData()
    }
    
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
           // return the number of sections
           return 1
       }


       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // return the number of items
           return products.count
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           
           let inset:CGFloat = 10
           return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
       }
       
       func collectionView(_ collectionView:UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: UIScreen.main.bounds.width, height: 80)
       }
       
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:LocalEventsCollectionViewCellId, for: indexPath) as! LocalEventsCollectionViewCell
           cell.ImageView.image = UIImage(named:"cat")
           return cell;
           
       }
}


   
   

