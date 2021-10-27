//
//  PlanetViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/20/21.
//

import Foundation

struct PlanetViewModel: DetailViewModelType {
    let name: String
    init(model: Planet) {
        self.name = model.name
    }
}
