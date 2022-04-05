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
    private let categoriesRepository: CategoriesRepositoryType
    
    init(categoriesRepository: CategoriesRepositoryType) {
        self.categoriesRepository = categoriesRepository
    }
    
    func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never> {
        categoriesRepository
            .fetchCategories()
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<[Category], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
