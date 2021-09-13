//
//  MainUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Combine
import Foundation

protocol MainUseCaseType {
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never>
    func loadDetails(type: DetailDataType, url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never>
}

final class MainUseCase: MainUseCaseType {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        return networkService
            .load(Resource<Categories>.categories())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
    
    func loadDetails(type: DetailDataType, url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never>  {
        switch type {
        case .film:
            return self.loadFilms(url)
        }
    }
    
    private func loadFilms(_ url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never> {
        return networkService
            .load(Resource<Film>.films(with: url))
            .map { .success($0 as! DetailsType) }
            .catch { error -> AnyPublisher<Result<DetailsType, Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }
}
