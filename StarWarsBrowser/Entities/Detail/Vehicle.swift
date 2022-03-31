//
//  Vehicle.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 16.01.2022.
//

import Foundation

struct Vehicle: Detailable {
    var imagePath: String { "vehicles/" + name }
    let name: String
}
