//
//  CreditCardModel.swift
//  Ticketing
//
//  Created by Carlos Mendoza on 11/14/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

class CreditCard: Codable {
    let fullName: String
    let cardNumber: String
    let expirationMonth: String
    let expirationYear: String

    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case cardNumber = "cardNumber"
        case expirationMonth = "expirationMonth"
        case expirationYear = "expirationYear"
    }

    init(fullName: String, cardNumber: String, expirationMonth: String, expirationYear: String) {
        self.fullName = fullName
        self.cardNumber = cardNumber
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
    }
}
