//
//  EventModel.swift
//  Ticketing
//
//  Created by Carlos Mendoza on 11/16/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

// MARK: - Event
class Event: Codable {
    let levels: [Level]?
    var eventID: String?

    enum CodingKeys: String, CodingKey {
        case levels = "levels"
    }

    init(levels: [Level]?) {
        self.levels = levels
    }
}

// MARK: - Level
class Level: Codable {
    let levelNum: Int?
    let sections: [Section]?

    enum CodingKeys: String, CodingKey {
        case levelNum = "levelNum"
        case sections = "sections"
    }

    init(levelNum: Int?, sections: [Section]?) {
        self.levelNum = levelNum
        self.sections = sections
    }
}

// MARK: - Section
class Section: Codable {
    let sectionNum: Int?
    let rows: [Row]?

    enum CodingKeys: String, CodingKey {
        case sectionNum = "sectionNum"
        case rows = "rows"
    }

    init(sectionNum: Int?, rows: [Row]?) {
        self.sectionNum = sectionNum
        self.rows = rows
    }
}

// MARK: - Row
class Row: Codable {
    let rowNum: Int?
    let price: Int?
    let numSeats: Int?

    enum CodingKeys: String, CodingKey {
        case rowNum = "rowNum"
        case price = "price"
        case numSeats = "numSeats"
    }

    init(rowNum: Int?, price: Int?, numSeats: Int?) {
        self.rowNum = rowNum
        self.price = price
        self.numSeats = numSeats
    }
}
