//
//  ViewController.swift
//  Ticketing
//
//  Created by Daniel Perez on 10/29/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class HomeViewController: UIViewController {
    
    // MARK: - Constants
    
    let locationManager = CLLocationManager()
    
    var data = [Suggested]()
    
    // MARK: Layouts
    
    fileprivate let eventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    fileprivate let upcomingView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    fileprivate let pastView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
           cv.backgroundColor = .clear
           return cv
       }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupLocationManager()
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        
        upcomingView.delegate = self
        upcomingView.dataSource = self
        
        pastView.delegate = self
        pastView.dataSource = self
        
        setup()
       
    }
    
// MARK: collectionView Setup
    
    func setup(){
        
        title = "Home"
        
        view.addSubview(eventCollectionView)
        view.addSubview(upcomingView)
        view.addSubview(pastView)
        
        // These are just constraints for the collection view
    
        NSLayoutConstraint.activate([
            
            eventCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventCollectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            
        ])
        
        NSLayoutConstraint.activate([
            
            upcomingView.topAnchor.constraint(equalTo: eventCollectionView.bottomAnchor, constant: 0.3 ),
            upcomingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4)
            
        ])
        
        NSLayoutConstraint.activate([
            
            pastView.topAnchor.constraint(equalTo: upcomingView.bottomAnchor, constant: 0.3 ),
            pastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
             
        ])
        
    
    }

}

// MARK: ViewController Delegates

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if collectionView == eventCollectionView{
             return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/2)
        }
         return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        return cell
    }
    
}

// MARK: CustomCell

class CustomCell: UICollectionViewCell {
    
    var data: Suggested? {
        didSet {
            guard let data = data else {return}
            AF.request(data.image).responseData { responseData in
                if let data = responseData.data {
                    self.bg.image = UIImage(data: data)
                }
            }
        }
    }
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "cat")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLoc: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        manager.stopUpdatingLocation()
        TicketmasterAPI.shared.getSuggested(latitude: userLoc.latitude, longitude: userLoc.longitude) { events in
            self.data = events
            self.eventCollectionView.reloadData()
        }
    }
}


