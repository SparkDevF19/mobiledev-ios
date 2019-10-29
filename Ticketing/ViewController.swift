//
//  ViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    let horizontalLayout: UICollectionViewFlowLayout  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    struct CellIdentifiers {
        static let eventsCell = "CollectionViewCell"
    }
    
    struct CellNibNames {
        static let eventsCell = "CollectionViewCell"
    }
    
    let eventImages: [UIImage] = [
        UIImage(named: "cat")!
    ]
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: horizontalLayout)
        
        view.addSubview(collectionView)
        setupConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(horizontalLayout, animated: true)

        let eventsNib = UINib(nibName: CellNibNames.eventsCell, bundle: nil)
        collectionView.register(eventsNib, forCellWithReuseIdentifier: CellIdentifiers.eventsCell)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.eventsCell, for: indexPath) as! CollectionViewCell
        cell.eventImage.image = UIImage(named: "cat")
        return  cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
    
}

