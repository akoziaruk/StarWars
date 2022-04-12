//
//  Film.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

struct Film: Detailable {
    var imagePath: String { "films/" + name }
    var name: String
    let openingCrawl: String
    let director: String
}
