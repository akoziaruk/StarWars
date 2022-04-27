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
}

extension Category {
    var type: T {
        return T(rawValue: name) ?? .unknown
    }
    
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

extension Category: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}

