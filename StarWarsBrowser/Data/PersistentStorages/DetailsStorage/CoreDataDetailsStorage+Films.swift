//
//  CoreDataDetailsStorage+Films.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//

import Foundation
import Combine
import CoreData

extension CoreDataDetailsStorage {
    private func fetchRequest(for requestDTO: FilmDetailsRequestDTO) -> NSFetchRequest<PersistentFilmDetail> {
        let request: NSFetchRequest = PersistentFilmDetail.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %d", #keyPath(PersistentFilmDetail.page), requestDTO.page)
        return request
    }

    private func delete(for requestDTO: FilmDetailsRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDTO)

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


extension CoreDataDetailsStorage: FilmsDefaultStorage {
    func request(for requestDTO: FilmDetailsRequestDTO) -> AnyPublisher<FilmDetailsDTO?, Error> {
        coreDataStorage
            .fetch(request: fetchRequest(for: requestDTO))
            .map { $0.toDTO() }
            .eraseToAnyPublisher()
    }
    
    func save(responseDTO: FilmDetailsDTO, requestDTO: FilmDetailsRequestDTO) {
        coreDataStorage.persistentContainer.performBackgroundTask { context in
            do {
                self.delete(for: requestDTO, in: context)

                responseDTO.results.forEach {
                    let _ = $0.toEntity(in: context, with: requestDTO)
                }

                try context.save()
            } catch {
                debugPrint("CoreDataCategoriesStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
