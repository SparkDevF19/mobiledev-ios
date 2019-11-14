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
    var cards: [CreditCard]?
    var favorites: [String]?
    let profilePic: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case cards = "cards"
        case favorites = "favorites"
        case profilePic = "profilePic"
    }
    
    init(firstName: String?, lastName: String?, cards: [CreditCard]?, favorites: [String]?, profilePic: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.cards = cards
        self.favorites = favorites
        self.profilePic = profilePic
    }
    
    init(firstName: String?, lastName: String?, cards: [CreditCard]?, favorites: [String]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.cards = cards
        self.favorites = favorites
        self.profilePic = nil
    }

    init(firstName: String?, lastName: String?, cards: [CreditCard]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.cards = cards
        self.profilePic = nil
    }
    
    init(firstName: String?, lastName: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.cards = nil
        self.profilePic = nil
    }
}
