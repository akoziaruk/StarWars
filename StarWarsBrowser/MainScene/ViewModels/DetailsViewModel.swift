//
//  DetailViewModelType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 23.06.2021.
//

import Foundation

class DetailsViewModel {
    var created: Date!
}

extension DetailsViewModel: Hashable {
    static func == (lhs: DetailsViewModel, rhs: DetailsViewModel) -> Bool {
        return lhs.created == rhs.created
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(created)
    }
}
