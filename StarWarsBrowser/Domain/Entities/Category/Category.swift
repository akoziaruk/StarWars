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
        return T(rawValue: name) ?? .unknown
    }
}

extension Category {
    enum T: String {
        case films
        case people
        case planets
        case species
        case starships
        case vehicles
        case unknown
    }
}
