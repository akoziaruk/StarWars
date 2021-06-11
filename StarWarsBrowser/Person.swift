//
//  StarWarsInfo.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import Foundation

struct Person: Hashable, Decodable {
        
    var name: String!

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
      lhs.name == rhs.name
    }
    
}

struct PeopleResponse: Decodable {
    let people: [Person]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        people = try container.decode([Person].self, forKey: CodingKeys.results)
    }
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
