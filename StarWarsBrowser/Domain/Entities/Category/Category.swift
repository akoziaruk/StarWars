//
//  Category.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.06.2021.
//

import Foundation

struct Category {
    var name: String!
    var url: URL!
    
    var type: T {
        switch name {
        case Titles.films.rawValue:
            return .film
        case Titles.people.rawValue:
            return .people
        case Titles.planets.rawValue:
            return .planet
        case Titles.species.rawValue:
            return .species
        case Titles.starships.rawValue:
            return .starship
        case Titles.vehicles.rawValue:
            return .vehicle
        default:
            return .unknown
        }
    }
}

extension Category {
    enum T {
        case film
        case people
        case planet
        case species
        case starship
        case vehicle
        case unknown
    }
    
    private enum Titles: String {
        case films = "films"
        case people = "people"
        case planets = "planets"
        case species = "species"
        case starships = "starships"
        case vehicles = "vehicles"
    }
}
