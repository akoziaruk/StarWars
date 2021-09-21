//
//  Categories.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

struct Categories: Decodable {
    let items: [Category]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)        
        items = try CodingKeys.allCases.map {
            let name = $0.rawValue
            let url = try container.decode(URL.self, forKey: $0)
            return Category(name: name,
                            url: url,
                            type: ItemType(name: name))
        }
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case films = "films"
        case people = "people"
        case planets = "planets"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
    }
}

fileprivate extension ItemType {
    init(name: String) {
        switch name {
        case Categories.CodingKeys.films.rawValue:
            self = .film
        case Categories.CodingKeys.people.rawValue:
            self = .people
        case Categories.CodingKeys.planets.rawValue:
            self = .planet
        case Categories.CodingKeys.species.rawValue:
            self = .species
        case Categories.CodingKeys.starships.rawValue:
            self = .starship
        case Categories.CodingKeys.vehicles.rawValue:
            self = .vehicle
        default:
            self = .unknown
        }
    }
}

