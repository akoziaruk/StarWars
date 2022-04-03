//
//  ServicesProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation
import CoreData

class ServicesProvider {
    let imageLoader: ImageLoaderServiceType
    let repositoryService: RepositoryType

    static func defaultProvider() -> ServicesProvider {
        let repositoryService = Repository(persistance: PersistanceDataService(),
                                                  network: NetworkService())
        let imageLoader = ImageLoaderService()
        
        return ServicesProvider(repositoryService: repositoryService, imageLoader: imageLoader)
    }

    init(repositoryService: RepositoryType, imageLoader: ImageLoaderServiceType) {
        self.repositoryService = repositoryService
        self.imageLoader = imageLoader
    }
}
