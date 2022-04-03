//
//  Categories+Persistence.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 02.04.2022.
//

import Foundation

extension Categories {
    init(persistentCategories: [PersistentCategory]) {
        self.items = persistentCategories.map { Category(name: $0.name, url: $0.url) }
    }
}
