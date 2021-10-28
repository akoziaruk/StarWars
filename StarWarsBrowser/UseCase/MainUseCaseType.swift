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
    func loadDetails(url: URL, page: Int, type: Category.T) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never>
}

final class MainUseCase: MainUseCaseType {
    let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        print("loadCategories")
        return networkService
            .load(Resource<Categories>.categories())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadDetails(url: URL, page: Int, type: Category.T) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
        print("loadDetails")
        switch type {
        case .film:
            return loadDetails(url: url, page: page, type: Film.self)
        case .people:
            return loadDetails(url: url, page: page, type: People.self)
        case .planet:
            return loadDetails(url: url, page: page, type: Planet.self)
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
    
    private func loadDetails<T: Detail>(url: URL, page: Int, type: T.Type) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
        networkService
            .load(Resource<DetailCollection<T>>(url: url))//, parameters: ["page" : page]))
            .map { .success($0.result) }
            .catch { error -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
