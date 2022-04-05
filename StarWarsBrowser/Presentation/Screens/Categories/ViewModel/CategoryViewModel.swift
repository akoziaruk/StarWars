//
//  CategoryViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import Foundation
import UIKit

class CategoryViewModel {
    var name: String
    let url: URL
    let type: Category.T
    let image: UIImage
    var isSelected: Bool
    
    init(_ category: Category, selected: Bool) {
        name = category.name.capitalized
        url = category.url
        type = category.type
        image = category.image
        isSelected = selected
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
