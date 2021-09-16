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
    func loadDetails(url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never>
}

enum UseCaseError: LocalizedError {
    case invalidType
    
    var description: String? {
        switch self {
        case .invalidType:            return "Invalid type"
        }
    }
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
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadDetails(url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never>  {
        switch url.type {
        case .film:
            return self.loadFilms(url)
        case .unknown:
            return .just(.failure(UseCaseError.invalidType))
        }
    }
    
    private func loadFilms(_ url: URL) -> AnyPublisher<Result<DetailsType, Error>, Never> {
        return networkService
            .load(Resource<Films>.films(with: url))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<DetailsType, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}

fileprivate extension URL {
    var type: DetailDataType {
        if self.absoluteString.contains("film") {
            return .film
        }
        return .unknown
    }
}
