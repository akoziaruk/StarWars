//
//  Species.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 16.01.2022.
//

import Foundation

struct Species: Detailable {
    var imagePath: String { "spiecies/" + name.snakeCase }
    let name: String
}
