//
//  ServicesProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceType
    let imageLoader: ImageLoaderServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        let imageLoader = ImageLoaderService()
        return ServicesProvider(network: network, imageLoader: imageLoader)
    }

    init(network: NetworkServiceType, imageLoader: ImageLoaderServiceType) {
        self.network = network
        self.imageLoader = imageLoader
    }
    
}
