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
    func loadDetails(with type: CategoryType, url: URL) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never>
}

final class MainUseCase: MainUseCaseType {
    let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        networkService
            .load(Resource<Categories>.categories())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadDetails(with type: CategoryType, url: URL) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
        switch type {
        case .film:
            return loadFilms(with: url)
        case .people:
            return loadPeople(with: url)
        case .planet:
            return .just(.failure(UseCaseError.unknownType))//loadPlanets(with: url)
        case .species:
            return .just(.failure(UseCaseError.unknownType))
        case .starship:
            return .just(.failure(UseCaseError.unknownType))
        case .vehicle:
            return .just(.failure(UseCaseError.unknownType))
        case .unknown:
            return .just(.failure(UseCaseError.unknownType))
        }
    }
}
