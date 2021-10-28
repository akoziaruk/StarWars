//
//  PlanetViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/20/21.
//

import Foundation

class PlanetViewModel: DetailViewModel {
    let name: String!
    init(model: Planet) {
        self.name = model.name
        super.init()
    }
}
