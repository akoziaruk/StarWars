//
//  DataService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

class DataProviderService: DataProviderServiceType {

    let persistance: PersistanceDataServiceType
    let network: NetworkServiceType
    
    init(persistance: PersistanceDataServiceType, network: NetworkServiceType) {
        self.persistance = persistance
        self.network = network
    }
    
    func loadCategories() -> AnyPublisher<Categories, Error> {
        // load categories from persistance storage
        // if any return
        // if no data in storage
        // download from server
        // save in core data
        // return data from persistance storage
        return PassthroughSubject<Categories, Error>()
            .eraseToAnyPublisher()
    }
    
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> where T : Decodable {
        network.load(resource)
    }
    
}
