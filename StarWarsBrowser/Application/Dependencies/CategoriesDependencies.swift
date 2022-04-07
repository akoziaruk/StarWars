//
//  CategoriesDependencies.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

class CategoriesDependencies {
    private let network: NetworkService
    private let storage: CategoriesStorage = CoreDataCategoriesStorage()

    private var repository: CategoriesRepositoryType {
        CategoriesRepository(network: network, storage: storage)
    }
    
    var useCase: CategoriesUseCaseType {
        CategoriesUseCase(repository: repository)
    }
    
    init(network: NetworkService) {
        self.network = network
    }
}
