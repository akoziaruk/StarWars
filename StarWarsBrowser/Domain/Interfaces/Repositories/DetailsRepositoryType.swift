//
//  DataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

protocol DetailsRepositoryType: AnyObject {
    func fetchDefaultDetails(url: URL, page: Int) -> AnyPublisher<[Detailable], Error>
    func fetchFilms(url: URL, page: Int) -> AnyPublisher<[Detailable], Error>
}
