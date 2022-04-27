//
//  DetailsViewModelTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class DetailsViewModelTests: XCTestCase {
    private let useCase = DetailsUseCaseMock()
    private var viewModel: DetailsViewModel!
    private var cancellables: [AnyCancellable] = []
    private let details = [DefaultDetail(name: "Luke Skywalker"),
                           DefaultDetail(name: "Darth Vader"),
                           DefaultDetail(name: "Leia Organa")]

    override func setUp() {
        super.setUp()
        
        let url = APIConstants.baseURL.appendingPathComponent("people")
        viewModel = DetailsViewModel(category: .people, url: url, useCase: useCase)
    }
    
    func test_load_succeeds() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = DetailsViewModelInput(loadNextPage: load.eraseToAnyPublisher())
        var state: DetailsLoadingState?

        let expectation = self.expectation(description: "details")
        let expectedViewModels = details.map { DetailViewModelFactory.viewModel(from: $0, imageLoader: { _ in .just(UIImage()) })}

        useCase.loadDetailsReturnValue = .just(.success(details))
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
    

    func test_load_fails() {
        // Given
        let load = PassthroughSubject<Void, Never>()
        let input = DetailsViewModelInput(loadNextPage: load.eraseToAnyPublisher())
        var state: DetailsLoadingState?
        let expectation = self.expectation(description: "details")
        let error = ErrorMock()
        
        useCase.loadDetailsReturnValue = .just(.failure(error))
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
