//
//  People.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/20/21.
//

import Foundation

struct People: Detail {
    var type: ItemType { .people }
    let name: String
//    let mass: Int
//    let hairColor: String
//    let skinColor: String
//    let eyeColor: String
//    let birthYear: String
//    let gender: Gender
    
//    enum CodingKeys: String, CodingKey {
//        case name
////        case mass
////        case gender
////        case hairColor = "hair_color"
////        case skinColor = "skin_color"
////        case eyeColor = "eye_color"
////        case birthYear = "birth_year"
//    }
    
//    enum Gender: String, Codable {
//        case male, female
//    }
}

struct PeopleCollection: DetailCollection, Decodable {
    var items: [Detail]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailCodingKeys.self)
        items = try container.decode([People].self, forKey: DetailCodingKeys.results)
    }
}
//
//    "name": "Luke Skywalker",
//    "height": "172",
//    "mass": "77",
//    "hair_color": "blond",
//    "skin_color": "fair",
//    "eye_color": "blue",
//    "birth_year": "19BBY",
//    "gender": "male",
//    "homeworld": "https://swapi.dev/api/planets/1/",
//    "films": [
//        "https://swapi.dev/api/films/1/",
//        "https://swapi.dev/api/films/2/",
//        "https://swapi.dev/api/films/3/",
//        "https://swapi.dev/api/films/6/"
//    ],
//    "species": [],
//    "vehicles": [
//        "https://swapi.dev/api/vehicles/14/",
//        "https://swapi.dev/api/vehicles/30/"
//    ],
//    "starships": [
//        "https://swapi.dev/api/starships/12/",
//        "https://swapi.dev/api/starships/22/"
//    ],
//    "created": "2014-12-09T13:50:51.644000Z",
//    "edited": "2014-12-20T21:17:56.891000Z",
//    "url": "https://swapi.dev/api/people/1/"
