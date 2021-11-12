//
//  DetailsViewModelTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//

import XCTest
@testable import StarWarsBrowser
import Combine

class DetailsViewModelTests: XCTestCase {
    private let useCase = MainUseCaseTypeMock()
    private let navigator = MainNavigatorMock()
    private var viewModel: DetailsViewModel!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        let url = APIConstants.baseURL.appendingPathComponent("films")
        viewModel = DetailsViewModel(category: Category.T.film, url: url, useCase: useCase)
    }
    
    func test_loadData_onSelection() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = DetailsViewModelInput(loadNextPage: load.eraseToAnyPublisher())
        var state: DetailsLoadingState?
        
        let expectation = self.expectation(description: "films")
        let films = Details<Film>.loadFromFile("Films.json", target: Self.self)
        let expectedViewModels = films.items.map { DetailViewModelFactory.viewModel(from: $0, imageLoader: { _ in .just(UIImage()) })}
        
        useCase.loadDetailsReturnValue = .just(.success(films.items))
        useCase.loadImageReturnValue = .just(UIImage())
        viewModel.transform(input: input).sink { value in
            guard case DetailsLoadingState.success = value else { return }
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
        let input = DetailsViewModelInput(loadNextPage: load.eraseToAnyPublisher())
        var state: DetailsLoadingState?
        let expectation = self.expectation(description: "films")
        
        useCase.loadDetailsReturnValue = .just(.failure(NetworkError.invalidResponse))
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
