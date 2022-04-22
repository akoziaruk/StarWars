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

extension DefaultDetailsDTO {
    func toDomain() -> [DefaultDetail] {
        return results.map { DefaultDetail(name: $0.name) }
    }
}
