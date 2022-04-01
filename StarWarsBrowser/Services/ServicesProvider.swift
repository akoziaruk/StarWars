//
//  ServicesProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation
import CoreData

class ServicesProvider {
    let network: NetworkServiceType
    let imageLoader: ImageLoaderServiceType
    let persistance: PersistanceDataServiceType

    static func defaultProvider() -> ServicesProvider {
        let persistance = PersistanceDataService()
        let decoder = PersistanceDecoder(managedObjectContext: persistance.viewContext)
        let network = NetworkService(decoder: decoder)
        let imageLoader = ImageLoaderService()
        
        return ServicesProvider(network: network, imageLoader: imageLoader, persistance: persistance)
    }

    init(network: NetworkServiceType, imageLoader: ImageLoaderServiceType, persistance: PersistanceDataServiceType) {
        self.network = network
        self.imageLoader = imageLoader
        self.persistance = persistance
    }
    
}
