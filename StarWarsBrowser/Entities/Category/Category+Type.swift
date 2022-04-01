//
//  Category+Type.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation

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
    
    var type: T {
        return T(name: name)
    }
    
}

fileprivate extension Category.T {
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
