//
//  EntityMapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import CoreData

extension Array where Element == PersistentCategory {
    func toDTO() -> CategoriesDTO {
        return CategoriesDTO(categories: self)
    }
}

extension CategoriesDTO {
    init(categories: [PersistentCategory]) {
        self.items = categories.map { CategoryDTO(name: $0.name, url: $0.url) }
    }
}

extension CategoryDTO {
    func toEntity(in context: NSManagedObjectContext) -> PersistentCategory {
        let category = PersistentCategory(context: context)
        category.name = name
        category.url = url
        return category
    }
}
