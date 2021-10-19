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
    func loadDetails(with type: CategoryType, url: URL) -> AnyPublisher<Result<DetailCollection, Error>, Never>
}

final class MainUseCase: MainUseCaseType {
    let networkService: NetworkServiceType
    
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
    
    func loadDetails(with type: CategoryType, url: URL) -> AnyPublisher<Result<DetailCollection, Error>, Never>  {
        switch type {
        case .films:
            return loadFilms(with: url)
        case .people:
            return loadPeople(with: url)
        case .planets:
            return .just(.failure(UseCaseError.unknownType))
        case .species:
            return .just(.failure(UseCaseError.unknownType))
        case .starships:
            return .just(.failure(UseCaseError.unknownType))
        case .vehicles:
            return .just(.failure(UseCaseError.unknownType))
        case .unknown:
            return .just(.failure(UseCaseError.unknownType))
        }
    }
}
