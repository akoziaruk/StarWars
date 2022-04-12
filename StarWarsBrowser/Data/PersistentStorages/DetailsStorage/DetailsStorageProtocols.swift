//
//  DetailsStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import Combine

protocol DetailsDefaultStorage {
    func request(for requestDTO: DefaultDetailsRequestDTO) -> AnyPublisher<DefaultDetailsDTO?, Error>
    func save(responseDTO: DefaultDetailsDTO, requestDTO: DefaultDetailsRequestDTO)
}

protocol FilmsDefaultStorage {
    func request(for requestDTO: FilmDetailsRequestDTO) -> AnyPublisher<FilmDetailsDTO?, Error>
    func save(responseDTO: FilmDetailsDTO, requestDTO: FilmDetailsRequestDTO)
}
