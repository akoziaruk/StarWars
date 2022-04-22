//
//  DetailsDependencies.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

class DetailsDependencies {
    private let network: NetworkServiceType
    private let imageLoader: ImageLoaderServiceType
    
    private var storage: DetailsStorageType {
        CoreDataDetailsStorage()
    }
    
    private var repository: DetailsRepositoryType {
        DetailsRepository(network: network, storage: storage)
    }
    
    var useCase: DetailsUseCaseType {
        DetailsUseCase(repository: repository)
    }
    
    init(network: NetworkServiceType, imageLoader: ImageLoaderServiceType) {
        self.network = network
        self.imageLoader = imageLoader
    }
}
