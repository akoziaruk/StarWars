//
//  DetailsDependencies.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

class DetailsDependencies {
    private let network: NetworkServiceType
    
    private var storage: DetailsStorageType = CoreDataDetailsStorage()
    private var imageCache: ImageCacheType = ImageCache()
    private var imageStorage: DataStorageType = DataStorage()
    
    private var imagesRepository: DetailImagesRepositoryType {
        DetailImagesRepository(cache: imageCache, storage: imageStorage)
    }
    
    private var repository: DetailsRepositoryType {
        DetailsRepository(network: network, storage: storage)
    }
    
    var useCase: DetailsUseCaseType {
        DetailsUseCase(repository: repository, imagesRepository: imagesRepository)
    }
    
    init(network: NetworkServiceType) {
        self.network = network
    }
}
