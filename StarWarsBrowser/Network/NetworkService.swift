//
//  StarWarsNetworkService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import Foundation
import Combine

struct NetworkService {
    
    func loadCategories() -> AnyPublisher<[Category], StarWarsAPIError> {
        let url = NetworkServiceConstants.baseURL
        let responsePublisher: AnyPublisher<CategoryResponse, StarWarsAPIError> = NetworkServiceManager.shared.requestAPI(url, httpMethod: .GET)
           
        return responsePublisher
            .map { $0.categories }
            .eraseToAnyPublisher()
    }
    
    func loadFilms(with url: String) -> AnyPublisher<[DetailType], StarWarsAPIError> {
        let responsePublisher: AnyPublisher<FilmsResponse, StarWarsAPIError> = NetworkServiceManager.shared.requestAPI(url, httpMethod: .GET)
           
        return responsePublisher
            .map { $0.values }
            .eraseToAnyPublisher()
    }
}
