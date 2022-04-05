//
//  PersistanceController.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import CoreData

//enum CoreDataStorageError: Error {
//    case readError(Error)
//    case saveError(Error)
//    case deleteError(Error)
//}

final class CoreDataStorage {

    static let shared = CoreDataStorage()
    
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
//            }
//        }
//    }

//    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
//        persistentContainer.performBackgroundTask(block)
//    }
}
