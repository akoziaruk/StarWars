//
//  FilmViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 23.06.2021.
//

import Foundation

struct FilmViewModel: DetailViewModelType {
    var name: String!
}

extension FilmViewModel: Hashable {
    static func == (lhs: FilmViewModel, rhs: FilmViewModel) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

