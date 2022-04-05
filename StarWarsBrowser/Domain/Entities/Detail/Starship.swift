//
//  Starship.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 16.01.2022.
//

import Foundation

struct Starship: Detailable {
    var imagePath: String { "starships/" + name }
    let name: String
}
