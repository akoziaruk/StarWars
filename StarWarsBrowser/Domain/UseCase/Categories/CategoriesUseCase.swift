//
//  CategoriesUseCase.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine
import CoreData

final class CategoriesUseCase: CategoriesUseCaseType {
    private let repository: CategoriesRepositoryType
    
    init(repository: CategoriesRepositoryType) {
        self.repository = repository
    }
    
    func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never> {
        repository
            .fetchCategories()
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[Category], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
