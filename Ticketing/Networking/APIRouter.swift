//
//  TicketmasterAPI.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/7/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    
    case suggestions(lat: Double?, long: Double?)
    
    // MARK: - HTTP Methods
    
    var method: HTTPMethod {
        switch self {
        case .suggestions:
            return .get
        }
    }
    
    // MARK: - Paths
    
    var path: String {
        switch self {
        case .suggestions(_, _):
            return "suggest"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .suggestions(let lat, let long):
            guard let lat = lat, let long = long else {
                return [K.APIParameterKey.apiKey: AppSecrets.tmApiClientSecret, K.APIParameterKey.latlong: "25.7617,80.1918"]
            }
            
            return [K.APIParameterKey.apiKey: AppSecrets.tmApiClientSecret, K.APIParameterKey.latlong: "\(lat),\(long)"]
            
        }
    }
    
    // MARK: - JSON Keys
    var jsonKeys: String? {
        switch self {
        case .suggestions(let lat, let long):
            return "links"
        }
    }
    
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
    
}
