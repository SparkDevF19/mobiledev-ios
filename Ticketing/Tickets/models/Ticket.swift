//
//  TicketDto.swift
//  Ticketing
//
//  Created by Maia Duschatzky on 10/10/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct Ticket {
    
    var id: Int?
    var name: String?
    var desc: String?
    
    init(id: Int, name: String, desc: String) {
        self.id = id
        self.name = name
        self.desc = desc
    }
    
}
