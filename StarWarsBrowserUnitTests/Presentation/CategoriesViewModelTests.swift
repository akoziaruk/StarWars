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
    private let useCase = CategoriesUseCaseMock()
    private let navigator = MainNavigatorMock()
    private var viewModel: CategoriesViewModel!
    private var cancellables: [AnyCancellable] = []
    private let categories = [Category(name: "films", url: URL(string: "https://swapi/films")!),
                              Category(name: "people", url: URL(string: "https://swapi/people")!),
                              Category(name: "planets", url: URL(string: "https://swapi/planets")!)]

    override func setUp() {
        super.setUp()
        
        viewModel = CategoriesViewModel(useCase: useCase, navigator: navigator)
    }
    
    func test_loadData_onStart() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = CategoriesViewModelInput(load: load.eraseToAnyPublisher(), select: .empty())
        
        var state: CategoriesLoadingState?
        let expectedViewModels = categories.map({ CategoryViewModel($0, selected: viewModel.selectedCategory == $0.type) })
        let expectation = self.expectation(description: "categories")
        
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
        let error = ErrorMock()
        
        useCase.loadCategoriesReturnValue = .just(.failure(error))
        viewModel.transform(input: input).sink { value in
            guard case .failure = value else { return }
            state = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // When
        load.send()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(state!, .failure(error))
    }

}
