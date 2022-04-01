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
    let dataProvider: DataProviderServiceType

    static func defaultProvider() -> ServicesProvider {
        let persistance = PersistanceDataService()
        let decoder = PersistanceDecoder(managedObjectContext: persistance.viewContext)
        let network = NetworkService(decoder: decoder)
        
        let dataProvider = DataProviderService(persistance: persistance, network: network)
        let imageLoader = ImageLoaderService()
        
        return ServicesProvider(dataProvider: dataProvider, imageLoader: imageLoader)
    }

    init(dataProvider: DataProviderServiceType, imageLoader: ImageLoaderServiceType) {
        self.dataProvider = dataProvider
        self.imageLoader = imageLoader
    }
}
