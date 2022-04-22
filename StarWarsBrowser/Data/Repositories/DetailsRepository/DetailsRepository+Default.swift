//
//  DetailsRepository+Default.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import Combine

extension DetailsRepository: DefaultDetailsRepositoryType {
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
}
