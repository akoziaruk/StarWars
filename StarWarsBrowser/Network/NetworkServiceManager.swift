//
//  NetworkServiceManager.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 10.06.2021.
//

import Foundation
import Combine

struct NetworkServiceConstants {
    static let baseURL = "https://swapi.dev/api/"
    static let people = "people/"
}

enum StarWarsAPIError: LocalizedError {
    case invalidURL
    case invalidParameters
    case requestError
    
    var description: String? {
        switch self {
        case .invalidURL:            return "Failed to create the request: Invalid URL"
        case .invalidParameters:     return "Failed to create the request: Invalid Parameters"
        case .requestError:          return "Request failed"
        }
    }
}

class NetworkServiceManager {
    
    static let shared = NetworkServiceManager()
    
    enum HTTPMethod: String {
        case GET
    }
    
    func requestAPI<T: Decodable>(_ url: String, httpMethod: HTTPMethod, parameters: [String: AnyObject]? = nil) -> AnyPublisher<T, StarWarsAPIError> {
        
        guard let url = URL(string: url) else {
            return Fail(error: StarWarsAPIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let requestParameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters, options: .prettyPrinted)
            } catch {
                return Fail(error: .invalidParameters).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in
                Fail(error: StarWarsAPIError.requestError).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}
