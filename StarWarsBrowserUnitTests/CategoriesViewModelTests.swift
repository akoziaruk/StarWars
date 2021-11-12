//
//  CategoriesViewModelTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class CategoriesViewModelTests: XCTestCase {
    private let useCase = MainUseCaseTypeMock()
    private let navigator = MainNavigatorMock()
    private var viewModel: CategoriesViewModel!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        viewModel = CategoriesViewModel(useCase: useCase, navigator: navigator)
    }
    
    func test_loadData_onStart() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = CategoriesViewModelInput(load: load.eraseToAnyPublisher(), select: .empty())
        var state: CategoriesLoadingState?
        
        let expectation = self.expectation(description: "categories")
        let categories = Categories.loadFromFile("Categories.json", target: Self.self)
        let expectedViewModels = categories.items.map({ CategoryViewModel($0, selected: viewModel.selectedCategory == $0.type) })
        
        useCase.loadCategoriesReturnValue = .just(.success(categories))
        viewModel.transform(input: input).sink { value in
            guard case CategoriesLoadingState.success = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // When
        load.send()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .success(expectedViewModels))
    }
    
    func test_hasErrorState_whenDataLoadingIsFailed() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = CategoriesViewModelInput(load: load.eraseToAnyPublisher(), select: .empty())
        var state: CategoriesLoadingState?
        let expectation = self.expectation(description: "categories")
        
        useCase.loadCategoriesReturnValue = .just(.failure(NetworkError.invalidResponse))
        viewModel.transform(input: input).sink { value in
            guard case .failure = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // When
        load.send()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .failure(NetworkError.invalidResponse))
    }

}
