//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: Detailable {
    var imagePath: String { "films/" + name.snakeCase }
    var name: String
    let openingCrawl: String
    let director: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case openingCrawl = "opening_crawl"
        case director
    }
}
