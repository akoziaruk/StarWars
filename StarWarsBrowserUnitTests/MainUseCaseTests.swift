//
//  MainUseCaseTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/11/21.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class MainUseCaseTests: XCTestCase {
    private let networkService = NetworkServiceTypeMock()
    private let imageLoaderService = ImageLoaderServiceTypeMock()
    private var useCase: MainUseCase!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        useCase = MainUseCase(networkService: networkService,
                              imageLoaderService: imageLoaderService)
    }
    
    func test_loadDetailsSucceeds() {
        // Given
        let url = APIConstants.baseURL.appendingPathComponent("films")
        var result: Result<[Detailable], Error>!
        let expectation = self.expectation(description: "films")
        let films = Details<Film>.loadFromFile("Films.json", target: Self.self)
        networkService.responses["/api/films"] = films

        // When
        useCase.loadDetails(url: url, page: 0, category: Category.T.film).sink { value in
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
    
    func test_loadDetails_onNetworkError() {
        // Given
        let url = APIConstants.baseURL.appendingPathComponent("films")
        var result: Result<[Detailable], Error>!
        let expectation = self.expectation(description: "films")
        networkService.responses["/api/films"] = NetworkError.invalidResponse

        // When
        useCase.loadDetails(url: url, page: 0, category: Category.T.film).sink { value in
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
    
    func test_loadCategoriesSucceeds() {
        // Given
        var result: Result<Categories, Error>!
        let expectation = self.expectation(description: "categories")
        let categories = Categories.loadFromFile("Categories.json", target: Self.self)
        networkService.responses["/api"] = categories

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
    
    func test_loadCategories_onNetworkError() {
        // Given
        var result: Result<Categories, Error>!
        let expectation = self.expectation(description: "categories")
        networkService.responses["/api"] = NetworkError.invalidResponse

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
    
    func test_loadsImageFromNetwork() {
        // Given
        let films = Details<Film>.loadFromFile("Films.json", target: Self.self)
        let film = films.items.first!
        var result: UIImage?
        let expectation = self.expectation(description: "loadImage")
        imageLoaderService.loadImageFromReturnValue = .just(UIImage())
        
        //When
        useCase.loadImage(for: film).sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
}
