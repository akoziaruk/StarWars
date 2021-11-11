//
//  CategoriesUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 11/11/21.
//

import Foundation
import Combine

protocol CategoriesUseCaseType {
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never>
}

final class CategoriesUseCase: CategoriesUseCaseType {
    private let networkService: NetworkServiceType

    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    public func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        networkService
            .load(Resource<Categories>.categories())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
