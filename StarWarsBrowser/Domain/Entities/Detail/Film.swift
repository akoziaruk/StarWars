//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: Detailable {    
    var name: String
    let openingCrawl: String
    let director: String
}

extension Film: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}
