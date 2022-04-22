//
//  DetailsRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine
import CoreData

final class DetailsRepository {
    let network: NetworkServiceType
    let storage: DetailsStorageType
    
    init(network: NetworkServiceType, storage: DetailsStorageType) {
        self.network = network
        self.storage = storage
    }
}
