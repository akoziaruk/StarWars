//
//  CategoryViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import Foundation
import UIKit

class CategoryViewModel {
    let uuid = UUID()
    var name: String
    let url: URL
    let type: ItemType
    let image: UIImage!
    
    init(_ category: Category) {
        name = category.name
        url = category.url
        type = category.type
        image = category.image
    }
}

extension CategoryViewModel: Hashable {
    static func == (lhs: CategoryViewModel, rhs: CategoryViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
