//
//  DetailsRepository+Films.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.04.2022.
//

import Foundation
import Combine

extension DetailsRepository: FilmsRepositoryType {
    func fetchFilms(url: URL, page: Int) -> AnyPublisher<[Detailable], Error> {
        let requestDTO = FilmDetailsRequestDTO(url: url, page: page)

        return Publishers.Merge(storage.request(for: requestDTO)
                                        .compactMap { $0?.toDomain() },
                                network.load(requestDTO.resource, jsonDecoder: FilmsDecoder())
                                        .handleEvents(receiveOutput: { [unowned self] filmsDTO in
                                            storage.save(responseDTO: filmsDTO, requestDTO: requestDTO)
                                        })
                                        .map { $0.toDomain() }
                                ).eraseToAnyPublisher()
    }
}
