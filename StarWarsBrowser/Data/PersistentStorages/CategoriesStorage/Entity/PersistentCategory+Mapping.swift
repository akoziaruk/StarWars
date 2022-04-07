//
//  EntityMapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import CoreData

extension PersistentCategory {
    func toDTO() -> Category {
        Category(name: name, url: url)
    }
}

extension Category {
    func toEntity(in context: NSManagedObjectContext) -> PersistentCategory {
        let category = PersistentCategory(context: context)
        category.name = name
        category.url = url
        return category
    }
}
