//
//  DetailsStorageType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import Combine

typealias DetailsStorageType = DefaultDetailsStorageType & FilmsStorageType

protocol DefaultDetailsStorageType {
    func request(for requestDTO: DefaultDetailsRequestDTO) -> AnyPublisher<DefaultDetailsDTO?, Error>
    func save(responseDTO: DefaultDetailsDTO, requestDTO: DefaultDetailsRequestDTO)
}

protocol FilmsStorageType {
    func request(for requestDTO: FilmDetailsRequestDTO) -> AnyPublisher<FilmDetailsDTO?, Error>
    func save(responseDTO: FilmDetailsDTO, requestDTO: FilmDetailsRequestDTO)
}
