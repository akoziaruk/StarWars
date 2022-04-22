//
//  CategoriesRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine

final class CategoriesRepository {
    let network: NetworkServiceType
    let storage: CategoriesStorageType
    
    init(network: NetworkServiceType, storage: CategoriesStorageType) {
        self.network = network
        self.storage = storage
    }
}

extension CategoriesRepository: CategoriesRepositoryType {
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        return Publishers.Merge(storage.requestAll()
                                        .map { $0.toDomain() },
                                network.load(Resource<CategoriesDTO>.categories())
                                        .handleEvents(receiveOutput: { [unowned self] categories in
                                            storage.save(categories)
                                        })
                                        .map { $0.toDomain() }
                                ).eraseToAnyPublisher()
    }
}
