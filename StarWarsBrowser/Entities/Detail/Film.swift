//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: Detail {
    var type: CategoryType { .films }
    let title: String!
    let director: String!
    let openingCrawl: String!
    
    enum CodingKeys: String, CodingKey {
        case title
        case director
        case openingCrawl = "opening_crawl"
    }
}

struct FilmCollection: DetailCollection, Decodable {
    var items: [Detail]
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailCodingKeys.self)
        items = try container.decode([Film].self, forKey: DetailCodingKeys.results)
    }
}

