//
//  TicketmasterAPI.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case failure
    case success
}

class TicketmasterClient {
    public func performRequest(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (JSON?, NetworkError) -> Void) {
        AF.request(route).responseJSON { response in
            guard let data = response.data else {
                completion(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            let results = json
            guard let empty = results?.isEmpty, empty == false else {
                completion(nil, .failure)
                return
            }
            
            completion(results, .success)
        }
    }
}
