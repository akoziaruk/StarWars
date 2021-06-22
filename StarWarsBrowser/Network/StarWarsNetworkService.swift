//
//  StarWarsNetworkService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import Foundation
import Combine

struct StarWarsNetworkService {
    
    func loadCategories() -> AnyPublisher<[Category], StarWarsAPIError> {
        let url = NetworkServiceConstants.baseURL
        let responsePublisher: AnyPublisher<CategoryResponse, StarWarsAPIError> = NetworkServiceManager.shared.requestAPI(url, httpMethod: .GET)
           
        return responsePublisher
            .map { $0.categories }
            .eraseToAnyPublisher()
    }
    
    func loadDetailsFor(_ url: String) -> AnyPublisher<Details, StarWarsAPIError> {
        let responsePublisher: AnyPublisher<DetailsResponse, StarWarsAPIError> = NetworkServiceManager.shared.requestAPI(url, httpMethod: .GET)
           
        return responsePublisher
            .map { $0.value }
            .eraseToAnyPublisher()
    }
    
}
