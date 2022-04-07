//
//  CategoriesRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine

final class CategoriesRepository: CategoriesRepositoryType {
    private let network: NetworkService
    private let storage: CategoriesStorage
    
    init(network: NetworkService, storage: CategoriesStorage) {
        self.network = network
        self.storage = storage
    }
        
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        return Publishers.Merge(storage.requestAll(),
                                network.load(Resource<CategoriesDTO>.categories())
                                        .map { $0.toDomain() }
                                        .handleEvents(receiveOutput: { [unowned self] categories in
                                            storage.save(categories)
                                        })
                                ).eraseToAnyPublisher()
    }
}
