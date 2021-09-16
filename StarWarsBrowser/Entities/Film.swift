//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: DetailType {
    var title: String!
    var director: String!
    var openingCrawl: String!
    
    enum CodingKeys: String, CodingKey {
        case title
        case director
        case openingCrawl = "opening_crawl"
    }
}

struct Films: DetailsType, Decodable {
    var items: [DetailType]
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Film].self, forKey: CodingKeys.results)
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case results = "results"
    }
}

