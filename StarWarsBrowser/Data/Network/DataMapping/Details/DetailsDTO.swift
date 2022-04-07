//
//  Details.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct DefaultDetailsDTO: Decodable {
    var results: [DetailDTO]
    
    struct DetailDTO: Decodable {
        let name: String
    }
}

struct FilmDetailsDTO: Decodable {
    var results: [FilmDTO]
    
    struct FilmDTO: Decodable {
        var name: String
        let openingCrawl: String
        let director: String
        
        enum CodingKeys: String, CodingKey {
            case name = "title"
            case openingCrawl = "opening_crawl"
            case director
        }
    }
}
