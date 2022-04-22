//
//  CategoriesDTO.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

struct CategoriesDTO: Decodable {
    var items = [CategoryDTO]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)        
        items = try CodingKeys.allCases.map {
            let name = $0.rawValue
            let url = try container.decode(URL.self, forKey: $0)
            return CategoryDTO(name: name,
                               url: url)
        }
    }
    
    struct CategoryDTO {
        let name: String
        let url: URL
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

extension CategoriesDTO {
    func toDomain() -> [Category] {
        return items.map { Category(name: $0.name, url: $0.url) }
    }
}

