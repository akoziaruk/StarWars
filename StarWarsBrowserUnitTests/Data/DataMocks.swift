//
//  DataMocks.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import Foundation
import Combine
@testable import StarWarsBrowser

class CategoriesStorageMock: CategoriesStorageType {
    var requestAllReturnValue: AnyPublisher<CategoriesDTO, Error>!
    func requestAll() -> AnyPublisher<CategoriesDTO, Error> {
        requestAllReturnValue
    }
    
    func save(_ categories: CategoriesDTO) { }
}

class DetailsStorageMock: DetailsStorageType {
    var requestDefaultDetailsReturnValue: AnyPublisher<DefaultDetailsDTO?, Error>!
    func request(for requestDTO: DefaultDetailsRequestDTO) -> AnyPublisher<DefaultDetailsDTO?, Error> {
        requestDefaultDetailsReturnValue
    }
    
    func save(responseDTO: DefaultDetailsDTO, requestDTO: DefaultDetailsRequestDTO) {}
    
    var requestFilmDetailsReturnValue: AnyPublisher<FilmDetailsDTO?, Error>!
    func request(for requestDTO: FilmDetailsRequestDTO) -> AnyPublisher<FilmDetailsDTO?, Error> {
        requestFilmDetailsReturnValue
    }
    
    func save(responseDTO: FilmDetailsDTO, requestDTO: FilmDetailsRequestDTO) {}
}


class NetworkServiceMock: NetworkServiceType {
    var responses = [String: Any]()

    func load<T>(_ resource: Resource<T>, jsonDecoder: JSONDecoder) -> AnyPublisher<T, Error> where T : Decodable {
        if let response = responses[resource.url.path] as? T {
            return .just(response)
        } else if let error = responses[resource.url.path] as? Error {
            return .fail(error)
        } else {
            return .fail(ErrorMock())
        }
    }
    
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> where T : Decodable {
        load(resource, jsonDecoder: JSONDecoder())
    }
}
