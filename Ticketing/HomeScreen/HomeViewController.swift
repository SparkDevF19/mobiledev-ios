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
    
    // MARK: - Properties
    var data = [Suggested]()
    
    // MARK: Layouts
    // MARK: - Events
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.text = "Events"
        return label
    }()
    
    fileprivate let eventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var eventStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventsLabel, eventCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Upcoming
    private let upcomingLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        return label
    }()
    
    fileprivate let upcomingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //  cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .white
        return cv
    }()
    
    private lazy var upcomingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [upcomingLabel, upcomingCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Past
    fileprivate let pastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .white
        return cv
    }()
    
    private let pastLabel: UILabel = {
        let label = UILabel()
        label.text = "Past"
        return label
    }()
    
    private lazy var pastStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pastLabel, pastCollectionView])
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - StackView container
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventStackView, upcomingStackView, pastStackView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        return scrollView
    }()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        
        pastCollectionView.delegate = self
        pastCollectionView.dataSource = self
        
        setupUI()
    }
    
    // MARK: UI Setup
    func setupUI() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pastStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            eventStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            upcomingStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
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
                self.bg.image = UIImage(data: responseData.data!)
            }
        }
    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "cat")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
