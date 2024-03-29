//
//  Event.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

// MARK: - Suggested Events
struct Suggested {
    let id: String
    let name: String
    let image: String
}

struct Image {
    let ratio: String
    let url: String
    let width: Int
    let height: Int
    let fallback: Bool
}
