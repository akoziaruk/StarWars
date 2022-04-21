//
//  CoreDataDetailsStorage+Default.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//

import Foundation
import Combine
import CoreData

extension CoreDataDetailsStorage {
    private func fetchRequest(for requestDTO: DefaultDetailsRequestDTO) -> NSFetchRequest<PersistentDefaultDetailRequest> {
        let request: NSFetchRequest = PersistentDefaultDetailRequest.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
                                        #keyPath(PersistentDefaultDetailRequest.url), requestDTO.url as NSURL,
                                        #keyPath(PersistentDefaultDetailRequest.page), requestDTO.page)
        return request
    }
    
    private func delete(for requestDTO: DefaultDetailsRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDTO)

        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataDetailsStorage: DetailsDefaultStorage {
    func request(for requestDTO: DefaultDetailsRequestDTO) -> AnyPublisher<DefaultDetailsDTO?, Error> {
            coreDataStorage
                .fetch(request: fetchRequest(for: requestDTO))
                .map { $0.first?.details.toDTO() }
                .eraseToAnyPublisher()
    }
    
    func save(responseDTO: DefaultDetailsDTO, requestDTO: DefaultDetailsRequestDTO) {
        coreDataStorage.persistentContainer.performBackgroundTask { context in
            do {
                self.delete(for: requestDTO, in: context)

                let request = requestDTO.toEntity(in: context)
                let details = responseDTO.results.map { $0.toEntity(in: context) }
                
                request.details = NSOrderedSet(array: details)
                
                try context.save()
            } catch {
                debugPrint("CoreDataCategoriesStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
