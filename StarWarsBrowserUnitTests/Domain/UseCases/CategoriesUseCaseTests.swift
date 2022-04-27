//
//  CategoriesUseCaseTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 26.04.2022.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class CategoriesUseCaseTests: XCTestCase {
    private let repository = CategoriesRepositoryMock()
    private var useCase: CategoriesUseCase!
    private var cancellables: [AnyCancellable] = []
    private let categories = [Category(name: "films", url: URL(string: "https://swapi/films")!),
                              Category(name: "people", url: URL(string: "https://swapi/people")!),
                              Category(name: "planets", url: URL(string: "https://swapi/planets")!)]

    override func setUp() {
        super.setUp()
        
        useCase = CategoriesUseCase(repository: repository)
    }
    
    func test_loadCategories_succeeds() {
        // Given
        var result: Result<[Category], Error>!
        let expectation = self.expectation(description: "categories")
        repository.fetchCategoriesReturnValue = .just(categories)
        
        // When
        useCase.loadCategories().sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }
    
    func test_loadCategories_fails() {
        // Given
        var result: Result<[Category], Error>!
        let expectation = self.expectation(description: "categories")
        repository.fetchCategoriesReturnValue = .fail(ErrorMock())

        // When
        useCase.loadCategories().sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure = result! else {
            XCTFail()
            return
        }
    }
}
