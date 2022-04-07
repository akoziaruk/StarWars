//
//  CoreDataStorage+Combine.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import CoreData
import Combine

extension CoreDataStorage {
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> AnyPublisher<[T], Error> {
        Deferred { [unowned persistentContainer] in
            Future { promise in
                persistentContainer.performBackgroundTask { context in
                    do {
                        let requestEntity = try context.fetch(request)
                        promise(.success(requestEntity))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
