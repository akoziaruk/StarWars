//
//  StarWarsNetworkService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import Foundation
import Combine

struct StarWarsNetworkService {
    
    func loadPeopeList() -> AnyPublisher<[Person], StarWarsAPIError> {
        let url = NetworkServiceConstants.baseURL + NetworkServiceConstants.people
        let responcePublisher: AnyPublisher<PeopleResponse, StarWarsAPIError> = NetworkServiceManager.shared.requestAPI(url: url, httpMethod: .GET)
           
        return responcePublisher
            .map { $0.people }
            .eraseToAnyPublisher()
    }
    
}
