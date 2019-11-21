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

class TicketmasterAPI {
    static let shared = TicketmasterAPI()
    
    public func getSuggested(latitude: Double, longitude: Double, completion: @escaping([Suggested]) -> Void) {
        TicketmasterClient().performRequest(route: .suggestions(lat: latitude, long: longitude)) { results, error in
            if case .failure = error { return }
            
            var resultEvents = [Suggested]()
            if let results = results, results.isEmpty == false {
                if let events = results["_embedded"]["attractions"].array {
                    for event in events {
                        if let images = event["images"].array {
                            for image in images {
                                if image["url"].stringValue.contains("RETINA_PORTRAIT_16_9") {
                                    resultEvents.append(Suggested(id: event["id"].stringValue, name: event["name"].stringValue, image: image["url"].stringValue))
                                }
                            }
                        }
                    }
                }
            }
            
            completion(resultEvents)
        }
    }
}
