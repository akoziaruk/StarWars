//
//  DomainMocks.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import Foundation
import Combine
import UIKit
@testable import StarWarsBrowser

class CategoriesRepositoryMock: CategoriesRepositoryType {
    var fetchCategoriesReturnValue: AnyPublisher<[Category], Error>!
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        fetchCategoriesReturnValue
    }
}

class DetailsRepositoryMock: DetailsRepositoryType {
    var fetchDetailsReturnValue: AnyPublisher<[Detailable], Error>!
    func fetchDefaultDetails(url: URL, page: Int) -> AnyPublisher<[Detailable], Error> {
        fetchDetailsReturnValue
    }
    func fetchFilms(url: URL, page: Int) -> AnyPublisher<[Detailable], Error> {
        fetchDetailsReturnValue
    }
}

class DetailImagesRepositoryMock: DetailImagesRepositoryType {
    var loadImageReturnValue: AnyPublisher<UIImage?, Never>!
    func loadImage(for detail: Detailable, category: Category.T) -> AnyPublisher<UIImage?, Never> {
        loadImageReturnValue
    }
}


