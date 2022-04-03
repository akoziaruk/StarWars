//
//  CoreDataRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine
import CoreData

enum RepositoryError: Error {
    case objectNotFound
}

class PersistanceDataService: PersistanceDataServiceType {
    var context: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    func fetch<T>(_ type: T.Type) -> AnyPublisher<[T], Error> where T : NSManagedObject {
        fetch(sortDescriptors: [], predicate: nil)
    }
    
    func fetch<T: NSManagedObject>(sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil) -> AnyPublisher<[T], Error> {
        Deferred { [context] in
            Future { promise in
                context.perform {
                    let request = T.fetchRequest()
                    request.sortDescriptors = sortDescriptors
                    request.predicate = predicate
                   
                    do {
                        let results = try context.fetch(request) as! [T]
                        if !results.isEmpty {
                            promise(.success(results))
                        } else {
                            promise(.failure(RepositoryError.objectNotFound))
                        }
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
   }

    func add<T: NSManagedObject>(_ type: T.Type, body: @escaping (inout T) -> Void) {
        context.perform {
            var entity = T(context: self.context)
            body(&entity)
        }
    }

    func save() {
        context.perform {
            do {
                try self.context.save()
            } catch {
                print("Failed to save Core Data")
            }
        }
    }

}
