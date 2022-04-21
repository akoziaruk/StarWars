//
//  DefaultDetailsRequestDTO.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//

import Foundation

struct FilmDetailsDTO: Decodable {
    var results: [FilmDTO]
    
    struct FilmDTO: Decodable {
        var name: String
        let openingCrawl: String
        let director: String
        let releaseDate: Date
        
        enum CodingKeys: String, CodingKey {
            case name = "title"
            case openingCrawl = "opening_crawl"
            case director
            case releaseDate = "release_date"
        }
    }
}

struct FilmDetailsRequestDTO {
    let url: URL
    let page: Int
    
    var resource: Resource<FilmDetailsDTO> {
        return Resource<FilmDetailsDTO>(url: url, parameters: ["page": page])
    }
}
