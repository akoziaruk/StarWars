//
//  PeopleCollection.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/19/21.
//

import Foundation

struct PeopleCollection: DetailCollection, Decodable {
    var items: [Detail]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailCodingKeys.self)
        items = try container.decode([People].self, forKey: DetailCodingKeys.results)
    }
}
