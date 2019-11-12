//
//  Event.swift
//  Ticketing
//
//  Created by Cassandra Zuria on 11/11/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import Foundation

// MARK: - Suggest
struct Suggest: Codable {
    let links: Links
    let embedded: Embedded

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let venues: [Venue]
    let attractions: [Attraction]
    let events, products: [Event]
}

// MARK: - Attraction
struct Attraction: Codable {
    let name: String
    let type: AttractionType
    let id: String
    let url: String
    let locale: Locale
    let externalLinks: ExternalLinks?
    let images: [Image]
    let classifications: [Classification]
    let upcomingEvents: [String: Int]
    let links: Links
    let aliases: [String]?

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, externalLinks, images, classifications, upcomingEvents
        case links = "_links"
        case aliases
    }
}

// MARK: - Classification
struct Classification: Codable {
    let primary: Bool
    let segment, genre, subGenre, type: Genre
    let subType: Genre
    let family: Bool
}

// MARK: - Genre
struct Genre: Codable {
    let id, name: String
}

// MARK: - ExternalLinks
struct ExternalLinks: Codable {
    let youtube: [Facebook]?
    let twitter: [Facebook]
    let itunes: [Facebook]?
    let lastfm, facebook: [Facebook]
    let instagram: [Facebook]?
    let musicbrainz: [Musicbrainz]
    let homepage: [Facebook]
    let wiki: [Facebook]?
}

// MARK: - Facebook
struct Facebook: Codable {
    let url: String
}

// MARK: - Musicbrainz
struct Musicbrainz: Codable {
    let id: String
}

// MARK: - Image
struct Image: Codable {
    let ratio: Ratio?
    let url: String
    let width, height: Int
    let fallback: Bool
    let attribution: String?
}

enum Ratio: String, Codable {
    case the16_9 = "16_9"
    case the3_1 = "3_1"
    case the3_2 = "3_2"
    case the4_3 = "4_3"
}

// MARK: - AttractionLinks
struct Links: Codable {
    let linksSelf: SelfElement

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfElement
struct SelfElement: Codable {
    let href: String
}

enum Locale: String, Codable {
    case enUs = "en-us"
}

enum AttractionType: String, Codable {
    case attraction = "attraction"
}

// MARK: - Event
struct Event: Codable {
    let name: String
    let type: EventType
    let id: String
    let url: String
    let locale: Locale
    let images: [Image]
    let distance: Double
    let units: Units
    let dates: Dates
    let classifications: [Classification]
    let location: Location
    let links: EventLinks
    let embedded: EventEmbedded

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, images, distance, units, dates, classifications, location
        case links = "_links"
        case embedded = "_embedded"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let start: Start
    let timezone: Timezone
    let status: Status
    let spanMultipleDays: Bool
}

// MARK: - Start
struct Start: Codable {
    let localDate, localTime: String
    let dateTime: Date
    let dateTBD, dateTBA, timeTBA, noSpecificTime: Bool
}

// MARK: - Status
struct Status: Codable {
    let code: Code
}

enum Code: String, Codable {
    case onsale = "onsale"
}

enum Timezone: String, Codable {
    case americaNewYork = "America/New_York"
}

// MARK: - EventEmbedded
struct EventEmbedded: Codable {
    let venues: [PurpleVenue]
    let attractions: [FluffyAttraction]
}

// MARK: - FluffyAttraction
struct FluffyAttraction: Codable {
    let name: String
    let type: AttractionType
    let id: String
    let url: String
    let locale: Locale
    let images: [Image]
    let classifications: [Classification]
    let upcomingEvents: UpcomingEvents
    let links: Links
    let aliases: [String]?

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, images, classifications, upcomingEvents
        case links = "_links"
        case aliases
    }
}

// MARK: - UpcomingEvents
struct UpcomingEvents: Codable {
    let total, ticketmaster: Int
    let tmr: Int?

    enum CodingKeys: String, CodingKey {
        case total = "_total"
        case ticketmaster, tmr
    }
}

// MARK: - PurpleVenue
struct PurpleVenue: Codable {
    let name: VenueName
    let type: VenueType
    let id: ID
    let url: String
    let locale: Locale
    let images: [Image]
    let distance: Double
    let units: Units
    let timezone: Timezone
    let city: City
    let state: State
    let country: Country
    let address: Address
    let location: Location
    let parkingDetail: String
    let accessibleSeatingDetail: AccessibleSeatingDetail
    let upcomingEvents: UpcomingEvents
    let links: Links
    let aliases: [String]?

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, images, distance, units, timezone, city, state, country, address, location, parkingDetail, accessibleSeatingDetail, upcomingEvents
        case links = "_links"
        case aliases
    }
}

enum AccessibleSeatingDetail: String, Codable {
    case thisIsAnAccessibleVenue = "This is an accessible venue."
}

// MARK: - Address
struct Address: Codable {
}

// MARK: - City
struct City: Codable {
    let name: String
}

// MARK: - Country
struct Country: Codable {
    let name: CountryName
    let countryCode: CountryCode
}

enum CountryCode: String, Codable {
    case us = "US"
}

enum CountryName: String, Codable {
    case unitedStatesOfAmerica = "United States Of America"
}

enum ID: String, Codable {
    case kovZpZAEkvtA = "KovZpZAEkvtA"
    case kovZpZAJtFaA = "KovZpZAJtFaA"
}

// MARK: - Location
struct Location: Codable {
    let longitude, latitude: String
}

enum VenueName: String, Codable {
    case americanAirlinesArena = "AmericanAirlines Arena"
    case hardRockStadium = "Hard Rock Stadium"
}

// MARK: - State
struct State: Codable {
    let name: StateName
    let stateCode: StateCode
}

enum StateName: String, Codable {
    case florida = "Florida"
}

enum StateCode: String, Codable {
    case fl = "FL"
}

enum VenueType: String, Codable {
    case venue = "venue"
}

enum Units: String, Codable {
    case miles = "MILES"
}

// MARK: - EventLinks
struct EventLinks: Codable {
    let linksSelf: SelfElement
    let attractions, venues: [SelfElement]

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case attractions, venues
    }
}

enum EventType: String, Codable {
    case event = "event"
}

// MARK: - Venue
struct Venue: Codable {
    let name: String
    let type: VenueType
    let id: String
    let url: String
    let locale: Locale
    let images: [Image]
    let distance: Double
    let units: Units
    let timezone: Timezone
    let city: City
    let state: State
    let country: Country
    let address: Address
    let location: Location
    let upcomingEvents: UpcomingEvents
    let links: Links
    let aliases: [String]?

    enum CodingKeys: String, CodingKey {
        case name, type, id, url, locale, images, distance, units, timezone, city, state, country, address, location, upcomingEvents
        case links = "_links"
        case aliases
    }
}
