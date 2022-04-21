//
//  NetworkService.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Combine
import Foundation

final class DefaultNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)) {
        self.session = session
    }

    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> where T : Decodable {
        load(resource, jsonDecoder: JSONDecoder())
    }
    
    func load<T>(_ resource: Resource<T>, jsonDecoder: JSONDecoder) -> AnyPublisher<T, Error> {
        guard let request = resource.request else {
            return .fail(NetworkError.invalidRequest)
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkError.invalidRequest }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return .fail(NetworkError.invalidRequest)
                }
                guard 200..<300 ~= response.statusCode else {
                    return .fail(NetworkError.dataLoadingError(statusCode: response.statusCode, data: data))
                }
                return .just(data)
            }
            .decode(type: T.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
    }
}
