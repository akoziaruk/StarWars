//
//  CategoriesUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine

protocol CategoriesUseCaseType {
    func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never>
}
