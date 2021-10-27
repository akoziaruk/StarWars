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
    func loadDetails<T: Detail>(url: URL, type: T.Type) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never>
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
    
    func loadDetails<T: Detail>(url: URL, type: T.Type) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
        networkService
            .load(Resource<DetailCollection<T>>(url: url))
            .map { .success($0.result) }
            .catch { error -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
