//
//  DetailsStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import Combine

protocol DetailsStorage {
    func request(for requestDTO: DetailsRequestDTO) -> AnyPublisher<DetailableDTO, Error>
}
