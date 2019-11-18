//
//  SeatSelectViewController.swift
//  Ticketing
//
//  Created by Carlos Mendoza on 10/31/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit

let seatCellIdentifier = "seatCell"

class SeatSelectViewController: UIViewController {
    
    // MARK: - Views
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let seatMap: UIImageView = {
        let seatMap = UIImageView()
        seatMap.translatesAutoresizingMaskIntoConstraints = false
        seatMap.image = UIImage(named: "seatMap.gif")
        seatMap.contentMode = .scaleAspectFit
        seatMap.clipsToBounds = true
        return seatMap
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(seatCell.self, forCellReuseIdentifier: seatCellIdentifier)
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(seatMap)
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: seatMap.bottomAnchor),
            seatMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seatMap.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            seatMap.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            seatMap.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3)
        ])
        
        
    }

}

// MARK: - TableView Delegates
extension SeatSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: seatCellIdentifier, for: indexPath) as! seatCell
        
        return cell
    }
    
}

// MARK: - Cell

class seatCell: UITableViewCell {
    
    let section: UILabel = {
        let section = UILabel()
        section.translatesAutoresizingMaskIntoConstraints = false
        section.font = UIFont.preferredFont(forTextStyle: .headline)
        section.numberOfLines = 1
        return section
    }()
    
    let row: UILabel = {
        let row = UILabel()
        row.translatesAutoresizingMaskIntoConstraints = false
        row.font = UIFont.preferredFont(forTextStyle: .subheadline)
        row.numberOfLines = 1
        row.sizeToFit()
        return row
    }()
    
    let price: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = UIFont.preferredFont(forTextStyle: .headline)
        price.numberOfLines = 1
        price.textAlignment = .right
        return price
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = .black
        return divider
    }()
    
    let numTickets: UILabel = {
        let numTickets = UILabel()
        numTickets.translatesAutoresizingMaskIntoConstraints = false
        numTickets.font = UIFont.preferredFont(forTextStyle: .caption1)
        numTickets.textColor = .gray
        numTickets.numberOfLines = 1
        return numTickets
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        section.text = "Club Box CB2"
        row.text = "Row 1"
        price.text = "$450.53"
        numTickets.text = "3 tickets"
        setupUI()
    }
    
    // MARK: - Cell SetupUI
    private func setupUI() {
        contentView.addSubview(section)
        contentView.addSubview(row)
        contentView.addSubview(divider)
        contentView.addSubview(numTickets)
        contentView.addSubview(price)
        
        NSLayoutConstraint.activate([
            section.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            section.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: section.bottomAnchor, constant: 10),
            row.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            row.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: row.topAnchor, constant: 3),
            divider.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: row.trailingAnchor, constant: 5),
            divider.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            numTickets.topAnchor.constraint(equalTo: row.topAnchor),
            numTickets.bottomAnchor.constraint(equalTo: row.bottomAnchor),
            numTickets.leadingAnchor.constraint(equalTo: divider.trailingAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            price.leadingAnchor.constraint(equalTo: section.trailingAnchor),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

