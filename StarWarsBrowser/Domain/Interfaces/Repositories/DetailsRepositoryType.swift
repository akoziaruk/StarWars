//
//  DetailsRepositoryType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

typealias DetailsRepositoryType = DefaultDetailsRepositoryType & FilmsRepositoryType

protocol DefaultDetailsRepositoryType: AnyObject {
    func fetchDefaultDetails(url: URL, page: Int) -> AnyPublisher<[Detailable], Error>
}

protocol FilmsRepositoryType: AnyObject {
    func fetchFilms(url: URL, page: Int) -> AnyPublisher<[Detailable], Error>
}
