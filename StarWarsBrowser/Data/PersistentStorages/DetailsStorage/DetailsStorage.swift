//
//  DetailsStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import Combine

protocol DetailsStorage {
    func getDetails() -> AnyPublisher<[Detailable], Error>
}
