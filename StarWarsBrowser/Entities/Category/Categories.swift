//
//  Categories.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

struct Categories: Decodable {
    var items = [Category]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)        
        items = try CodingKeys.allCases.map {
            let name = $0.rawValue
            let url = try container.decode(URL.self, forKey: $0)
            return Category(name: name,
                            url: url)
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

