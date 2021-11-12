//
//  Details.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Details<T: Detailable>: Decodable {
    var items: [Detailable]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailCodingKeys.self)
        items = try container.decode([T].self, forKey: DetailCodingKeys.results)
    }
    
    enum DetailCodingKeys: String, CodingKey, CaseIterable {
        case results
    }
}
