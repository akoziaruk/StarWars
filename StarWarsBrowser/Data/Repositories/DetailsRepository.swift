//
//  DataService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine
import CoreData

final class DetailsRepository: DetailsRepositoryType {
    private let network: NetworkService
    private let storage: DetailsStorage
    
    init(network: NetworkService, storage: DetailsStorage) {
        self.network = network
        self.storage = storage
    }
    
    func fetchDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<[Detailable], Error> {
        
        //Film or Default
        let requestDTO = DetailsRequestDTO(url: url, page: page, category: category.rawValue)
        
//        Resource<FilmsDTO>.defaultDetails(for: url, page: page)
//        Resource<DefaultDetailsDTO>.films(for: url, page: page)

        return storage
                    .request(for: requestDTO)
                    .eraseToAnyPublisher()
        
//        return Publishers.Merge(storage.requestAll()
//                                        .map { $0.toDomain() },
//                                network.load(Resource<CategoriesDTO>.categories())
//                                        .handleEvents(receiveOutput: { [unowned self] categories in
//                                            storage.save(categories)
//                                        })
//                                        .map { $0.toDomain() }
//                                ).eraseToAnyPublisher()
        
    }
    
//    func fetchDetails() -> AnyPublisher<[Detailable], Error> {
//        storage
//            .getDetails()
//            .eraseToAnyPublisher()

            
        // get from repository
        // if failed get from network
        // save to repository
//    }
}

struct DetailsRequestDTO {
    let url: URL
    let page: Int
    let category: String
    
    var type: DetailableDTO.Type {
        if category == "films" {
            return DefaultDetailsDTO.self
        }
        return FilmDetailsDTO.self
    }
}
//
//protocol DetailInitable {
//    init(detail: PersistentDetail)
//}
