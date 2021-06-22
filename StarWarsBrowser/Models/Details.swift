//
//  StarWarsInfo.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import Foundation

struct Details {
    
    var data: [Film]!
    
    
    /*
     "films": "https://swapi.dev/api/films/",
     "people": "https://swapi.dev/api/people/",
     "planets": "https://swapi.dev/api/planets/",
     "species": "https://swapi.dev/api/species/",
     "starships": "https://swapi.dev/api/starships/",
     "vehicles": "https://swapi.dev/api/vehicles/"
     */
}

struct DetailsResponse: Decodable {
    let value: Details!
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let values = try container.decode([Film].self, forKey: CodingKeys.results)
        value = Details(data: values)
    }
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
