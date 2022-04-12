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

struct DefaultDetailsRequestDTO {
    let url: URL
    let page: Int
    
    var resource: Resource<DefaultDetailsDTO> {
        return Resource<DefaultDetailsDTO>(url: url, parameters: ["page": page])
    }
}
