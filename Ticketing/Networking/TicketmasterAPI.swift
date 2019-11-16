//
//  TicketmasterAPI.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class TicketmasterAPI {
    static func getSuggested(latitude: Double, longitude: Double) {
        TicketmasterClient().performRequest(route: .suggestions(lat: latitude, long: longitude)) { results, error in
            guard error == .failure else { return }
            
            if let results = results, results.isEmpty == false {
                
            }
        }
    }
}
