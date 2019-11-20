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
    
    var event: Event?
    var eventID: String?
    var rows: [SeatRow] = []
    var ticketsNeeded = 1
    
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
    
    let centerContainer: UIView = {
        let centerContainer = UIView()
        centerContainer.translatesAutoresizingMaskIntoConstraints = false
        return centerContainer
    }()
    
    let tickets: UILabel = {
        let tickets = UILabel()
        tickets.translatesAutoresizingMaskIntoConstraints = false
        tickets.font = UIFont.preferredFont(forTextStyle: .title3)
        tickets.numberOfLines = 1
//        tickets.text = "1 Ticket"
        return tickets
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.wraps = false
        stepper.maximumValue = 25
        stepper.minimumValue = 1
        return stepper
    }()
    
    @objc func changeTicket(){
        ticketsNeeded = Int(stepper.value)
        if ticketsNeeded == 1 {
            tickets.text = "\(ticketsNeeded) Ticket"
        } else {
            tickets.text = "\(ticketsNeeded) Tickets"
        }
        rows = []
        getRows()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(seatCell.self, forCellReuseIdentifier: seatCellIdentifier)
        
        stepper.addTarget(self, action: #selector(changeTicket), for: .valueChanged)
        
        stepper.value = 1
        tickets.text = "\(ticketsNeeded) Ticket"
        
        view.backgroundColor = .white
        
        eventID = "1247"
        
        setupUI()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let id = eventID {
            FirebaseAPI.shared.getEvent(eventID: id) { (error, event) in
                if let error = error {
                    print(error)
                }
                
                if let event = event {
                    self.event = event
                    self.getRows()
                }
            }
        }
    }
    
    private func getRows() {
        guard let event = event else {return}
    
        event.levels?.forEach({ (level) in
            level.sections?.forEach({ (section) in
                section.rows?.forEach({ (row) in
                    if row.rowNum != nil && row.numSeats! >= ticketsNeeded {
                        self.rows.append(SeatRow(row: row, section: section.sectionNum!, level: level.levelNum!))
                    }
                })
            })
        })
        
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(seatMap)
        view.addSubview(centerContainer)
        
        centerContainer.addSubview(tickets)
        centerContainer.addSubview(stepper)
        
        NSLayoutConstraint.activate([
            tickets.leadingAnchor.constraint(equalTo: centerContainer.leadingAnchor, constant: 10),
            tickets.topAnchor.constraint(equalTo: centerContainer.topAnchor, constant: 10),
            tickets.bottomAnchor.constraint(equalTo: centerContainer.bottomAnchor, constant: -10),
            stepper.trailingAnchor.constraint(equalTo: centerContainer.trailingAnchor, constant: -10),
            stepper.topAnchor.constraint(equalTo: centerContainer.topAnchor, constant: 10),
            stepper.bottomAnchor.constraint(equalTo: centerContainer.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            centerContainer.topAnchor.constraint(equalTo: seatMap.bottomAnchor),
            centerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            centerContainer.bottomAnchor.constraint(equalTo: tableView.topAnchor),
        ])
        
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            tableView.topAnchor.constraint(equalTo: seatMap.bottomAnchor),
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
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: seatCellIdentifier, for: indexPath) as! seatCell
            
        cell.section.text = "Section \(rows[indexPath.row].section)"
        
        
        if let rowNum = rows[indexPath.row].row.rowNum {
            cell.row.text = "Row \(rowNum)"
        }
        
        if let numSeats = rows[indexPath.row].row.numSeats {
            cell.numTickets.text = "\(numSeats) tickets"
        }
        
        if let price = rows[indexPath.row].row.price {
            cell.price.text = "$\(price)"
        }
        
        
        
        return cell
    }
    
    class SeatRow {
        let row : Row
        let section: Int
        let level: Int
        
        init(row: Row, section: Int, level: Int) {
            self.row = row
            self.section = section
            self.level = level
        }
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

