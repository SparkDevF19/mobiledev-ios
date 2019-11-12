//
//  TicketmasterAPI.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import Alamofire

class TicketmasterAPI {
    static func getSuggested(latitude: Double, longitude: Double, completion: @escaping (AFResult<Suggest>) -> Void) {
        TicketmasterClient.performRequest(route: .suggestions(lat: latitude, long: longitude), completion: completion)
    }
}
