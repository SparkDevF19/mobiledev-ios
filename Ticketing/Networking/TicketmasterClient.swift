//
//  TicketmasterAPI.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Alamofire

class TicketmasterClient {
    public static func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
}
