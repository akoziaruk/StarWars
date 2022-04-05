//
//  Category+Type.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 02.04.2022.
//

import Foundation

extension Category {
    var type: T {
        switch name {
        case Categories.CodingKeys.films.rawValue:
            return .film
        case Categories.CodingKeys.people.rawValue:
            return .people
        case Categories.CodingKeys.planets.rawValue:
            return .planet
        case Categories.CodingKeys.species.rawValue:
            return .species
        case Categories.CodingKeys.starships.rawValue:
            return .starship
        case Categories.CodingKeys.vehicles.rawValue:
            return .vehicle
        default:
            return .unknown
        }
    }
}
