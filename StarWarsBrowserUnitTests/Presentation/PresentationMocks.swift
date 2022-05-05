//
//  PresentationMocks.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import Foundation
import Combine
import UIKit
@testable import StarWarsBrowser

class MainNavigatorMock: MainNavigator {
    func show(_ category: SelectedCategory) {}
}

class CategoriesUseCaseMock: CategoriesUseCaseType {
    var loadCategoriesReturnValue: AnyPublisher<Result<[Category], Error>, Never>!    
    func loadCategories() -> AnyPublisher<Result<[Category], Error>, Never> {
        return loadCategoriesReturnValue
    }
}

class DetailsUseCaseMock: DetailsUseCaseType {
    var loadDetailsReturnValue: AnyPublisher<Result<[Detailable], Error>, Never>!
    func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        loadDetailsReturnValue
    }
    
    var loadImageReturnValue: AnyPublisher<UIImage?, Never>!
    func loadImage(for detail: Detailable, category: Category.T) -> AnyPublisher<UIImage?, Never> {
        loadImageReturnValue
    }
}
