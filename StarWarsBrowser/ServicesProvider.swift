//
//  ServicesProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

class ServicesProvider {
    let network: NetworkServiceType

    static func defaultProvider() -> ServicesProvider {
        let network = NetworkService()
        return ServicesProvider(network: network)
    }

    init(network: NetworkServiceType) {
        self.network = network
    }
    
}
