//
//  CategoryViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 6/24/21.
//

import Foundation

class CategoryViewModel {
    var name: String!
    let url: String!
    init(_ category: Category) {
        name = category.name
        url = category.url
    }
}

extension CategoryViewModel: Hashable {
    static func == (lhs: CategoryViewModel, rhs: CategoryViewModel) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
