//
//  DetailsUseCaseTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class DetailsUseCaseTests: XCTestCase {
    private let dataRepository = DetailsRepositoryMock()
    private let imagesRepository = DetailImagesRepositoryMock()
    private var useCase: DetailsUseCase!
    private var cancellables: [AnyCancellable] = []

    private let url = APIConstants.baseURL.appendingPathComponent("people")
    private let details = [DefaultDetail(name: "Luke Skywalker"),
                           DefaultDetail(name: "Darth Vader"),
                           DefaultDetail(name: "Leia Organa")]

    override func setUp() {
        super.setUp()
        
        useCase = DetailsUseCase(repository: dataRepository, imagesRepository: imagesRepository)
    }
    
    func test_load_Succeeds() {
        // Given
        var result: Result<[Detailable], Error>!
        let expectation = self.expectation(description: "details")
        dataRepository.fetchDetailsReturnValue = .just(details)
        
        // When
        useCase.loadDetails(url: url , page: 1, category: .people).sink { value in
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
    
    func test_load_onNetworkError() {
        // Given
        var result: Result<[Detailable], Error>!
        let expectation = self.expectation(description: "details")
        dataRepository.fetchDetailsReturnValue = .fail(ErrorMock())

        // When
        useCase.loadDetails(url: url, page: 1, category: .people).sink { value in
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

    func test_load_imageFromNetwork() {
        // Given
        let detail = details.first!
        var result: UIImage?
        let expectation = self.expectation(description: "loadImage")
        imagesRepository.loadImageReturnValue = .just(UIImage())

        // When
        useCase.loadImage(for: detail, category: .people).sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
}
