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
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    fileprivate let eventCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
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
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
        return label
    }()
    
    fileprivate let upcomingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //  cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .clear
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
        label.font = UIFont.preferredFont(for: .title3, weight: .bold)
        label.textColor = .systemGray
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
        title = "Home"
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pastStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            eventStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            upcomingStackView.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            upcomingStackView.widthAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.widthAnchor, multiplier: 1)
        ])
        
        eventStackView.setCustomSpacing(10, after: eventsLabel)
        upcomingStackView.setCustomSpacing(10, after: upcomingLabel)
        pastStackView.setCustomSpacing(10, after: pastLabel)
        
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Look for your next event"
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
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
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        contentView.layer.cornerRadius = 10
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

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        if let searchText = searchController.searchBar.text {
//            filterContent(for: searchText)
//            // Reload the table view with the search result data.
//            tableView.reloadData()
//        }
    }
}
