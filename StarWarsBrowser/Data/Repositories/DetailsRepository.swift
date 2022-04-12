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
    private let storage: DetailsDefaultStorage & FilmsDefaultStorage
    
    init(network: NetworkService, storage: DetailsDefaultStorage & FilmsDefaultStorage) {
        self.network = network
        self.storage = storage
    }
    
    //MARK: - Default Details
    
    func fetchDefaultDetails(url: URL, page: Int) -> AnyPublisher<[Detailable], Error> {
        let requestDTO = DefaultDetailsRequestDTO(url: url, page: page)
        
        return Publishers.Merge(storage.request(for: requestDTO)
                                        .compactMap { $0?.toDomain() },
                                
                                network.load(requestDTO.resource)
                                        .handleEvents(receiveOutput: { [unowned self] detailsDTO in
                                            storage.save(responseDTO: detailsDTO, requestDTO: requestDTO)
                                        })
                                        .map { $0.toDomain() }
                                ).eraseToAnyPublisher()
    }

    //MARK: - Films
    
    func fetchFilms(url: URL, page: Int) -> AnyPublisher<[Detailable], Error> {
        let requestDTO = FilmDetailsRequestDTO(url: url, page: page)
        
        return Publishers.Merge(storage.request(for: requestDTO)
                                        .compactMap { $0?.toDomain() },
                                
                                network.load(requestDTO.resource)
                                        .handleEvents(receiveOutput: { [unowned self] filmsDTO in
                                            storage.save(responseDTO: filmsDTO, requestDTO: requestDTO)
                                        })
                                        .map { $0.toDomain() }
                                ).eraseToAnyPublisher()
    }
}
