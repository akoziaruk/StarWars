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
    var type: T!
    
    enum T {
        case film
        case people
        case planet
        case species
        case starship
        case vehicle
        case unknown
    }
}
