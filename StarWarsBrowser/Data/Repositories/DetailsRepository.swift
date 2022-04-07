//
//  DataService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine
import CoreData

final class DetailsRepository: DetailsRepositoryType {
    private let network: NetworkService
    private let storage: DetailsStorage
    
    init(network: NetworkService, storage: DetailsStorage) {
        self.network = network
        self.storage = storage
    }
    
    func fetchDetails() -> AnyPublisher<[Detailable], Error> {
        storage
            .getDetails()
            .eraseToAnyPublisher()

            
        // get from repository
        // if failed get from network
        // save to repository
    }
}


//class Repository: RepositoryType {
//    let persistance: PersistanceDataServiceType
//    let network: NetworkServiceType
//
//    init(persistance: PersistanceDataServiceType, network: NetworkServiceType) {
//        self.persistance = persistance
//        self.network = network
//    }
//
//    func loadCategories() -> AnyPublisher<[Category], Error> {
//        persistance
//            .fetch(PersistentCategory.self)
//            .map { $0.map { Category(name: $0.name, url: $0.url) } }
//            .catch { [unowned self] _ in
//                network
//                    .load(Resource<Categories>.categories())
//                    .map { $0.items }
//                    .handleEvents(receiveOutput: { [unowned self] categories in
//                        saveCategories(categories)
//                    })
//            }
//            .eraseToAnyPublisher()
//    }
//
//    private func saveCategories(_ categories: [Category]) {
//        for category in categories {
//            persistance.add(PersistentCategory.self) { persistantCategory in
//                persistantCategory.name = category.name
//                persistantCategory.url = category.url
//            }
//        }
//        persistance.save()
//    }
//
//}