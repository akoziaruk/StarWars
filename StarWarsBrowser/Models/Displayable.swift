//
//  Displayable.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

protocol Displayable: Hashable, Decodable {
    var name: String! { get set }
}

extension Displayable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
