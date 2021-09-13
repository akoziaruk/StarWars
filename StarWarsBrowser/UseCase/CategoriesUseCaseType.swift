//
//  CategoriesUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Combine

protocol CategoriesUseCaseType {
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never>
}

final class CategoriesUseCase: CategoriesUseCaseType {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        return networkService
            .load(Resource<Categories>.categories())
            .map{ .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .eraseToAnyPublisher()
    }

}
