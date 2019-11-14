//
//  UserModel.swift
//  Ticketing
//
//  Created by Carlos Mendoza on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

// MARK: - User
class UserData: Codable {
    let firstName: String?
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
    }

    init(firstName: String?, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
