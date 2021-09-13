//
//  Category.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.06.2021.
//

import Foundation

struct Category: Decodable {
    var name: String!
    var url: String!
}

extension Category {
    var type: DetailDataType? {
        switch name {
        case "Film":
            return .film
        default:
            return nil
        }
        
    }
}
