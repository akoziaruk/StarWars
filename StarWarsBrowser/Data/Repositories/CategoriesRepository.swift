//
//  CategoriesRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine

final class CategoriesRepository: CategoriesRepositoryType {
    private let networkService: NetworkService
    private let storage: CategoriesStorage
    
    init(networkService: NetworkService, storage: CategoriesStorage) {
        self.networkService = networkService
        self.storage = storage
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        storage.getCategories()
            .eraseToAnyPublisher()
//        storage
//            .getCategories()
            
        // get from repository
        // if failed get from network
        // save to repository
    }
}

