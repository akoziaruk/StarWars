//
//  CategoriesDependencies.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

class CategoriesDependencies {
    private let network: NetworkServiceType

    private var storage: CategoriesStorageType {
        CoreDataCategoriesStorage()
    }
    
    private var repository: CategoriesRepositoryType {
        CategoriesRepository(network: network, storage: storage)
    }
    
    var useCase: CategoriesUseCaseType {
        CategoriesUseCase(repository: repository)
    }
    
    init(network: NetworkServiceType) {
        self.network = network
    }
}
