//
//  Category.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.06.2021.
//

import Foundation

struct Category: Hashable, Decodable {
    var name: String!
    var url: String!

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name
    }
    
}

struct CategoryResponse: Decodable {
    let categories: [Category]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        categories = try CodingKeys.allCases.map {
            let name = $0.rawValue
            let url = try container.decode(String.self, forKey: $0)
            return Category(name: name, url: url)
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

