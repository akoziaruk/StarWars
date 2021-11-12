//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: Detailable {
    var imagePath: String { "films/" + title.snakeCase }
    let title: String!
    let director: String!
    let openingCrawl: String!
    
    enum CodingKeys: String, CodingKey {
        case title
        case director
        case openingCrawl = "opening_crawl"
    }
}
