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
        let request = PersistentCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(PersistentCategory.name), ascending: true)]
        return request
    }
    
    private func deleteAll(in context: NSManagedObjectContext) {
        let request = fetchRequest()
        do {
            let result = try context.fetch(request)
            result.forEach {
                context.delete($0)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataCategoriesStorage: CategoriesStorageType {
    func requestAll() -> AnyPublisher<CategoriesDTO, Error> {
        coreDataStorage
            .fetch(request: fetchRequest())
            .map { $0.toDTO() }
            .eraseToAnyPublisher()
    }
    
    func save(_ categories: CategoriesDTO) {
        coreDataStorage.persistentContainer.performBackgroundTask { context in
            do {
                self.deleteAll(in: context)
                categories.items.forEach {
                    let _ = $0.toEntity(in: context)
                }
                try context.save()
            } catch {
                debugPrint("CoreDataCategoriesStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
