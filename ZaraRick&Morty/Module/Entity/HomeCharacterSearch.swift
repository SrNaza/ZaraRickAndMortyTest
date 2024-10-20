//
//  CharacterSearch.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import Foundation

struct HomeCharacterSearch: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    init() {
        self.id = 0
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
        self.image = ""
        self.episode = []
        self.url = ""
        self.created = ""
    }
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: Location,
        location: Location,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

struct Location: Codable {
    let name: String
    let url: String
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
