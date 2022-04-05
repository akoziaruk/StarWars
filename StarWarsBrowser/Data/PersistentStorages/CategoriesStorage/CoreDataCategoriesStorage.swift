//
//  CoreDataCategoriesStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import CoreData
import Combine

class CoreDataCategoriesStorage {
    var coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    private func fetchRequest() -> NSFetchRequest<PersistentCategory> {
        return PersistentCategory.fetchRequest()
    }
}

extension CoreDataCategoriesStorage: CategoriesStorage {
    func getCategories() -> AnyPublisher<[Category], Error> {
        coreDataStorage
            .fetch(request: fetchRequest())
            .map { $0.map { $0.toDTO() } }
            .eraseToAnyPublisher()
    }
}

extension PersistentCategory {
    func toDTO() -> Category {
        Category(name: name, url: url)
    }
}
