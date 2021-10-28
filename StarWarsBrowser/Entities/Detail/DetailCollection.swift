//
//  DetailCollection.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct DetailCollection<T: Detail>: Decodable {
    var items: [Detail]
    var count: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailCodingKeys.self)
        items = try container.decode([T].self, forKey: DetailCodingKeys.results)
        count = try container.decode(Int.self, forKey: DetailCodingKeys.count)
    }
    
    enum DetailCodingKeys: String, CodingKey, CaseIterable {
        case results
        case count
    }
}
