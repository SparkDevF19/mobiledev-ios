//
//  URLConstants.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/7/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

struct K {
    
    struct ProductionServer {
        static let baseURL = "https://app.ticketmaster.com/discovery/v2/"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    enum ContentType: String {
        case json = "application/json"
    }
    
    struct APIParameterKey {
        static let apiKey = "apikey"
        static let latlong = "latlong"
    }
    
}
