//
//  NetworkServiceTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/11/21.
//

import XCTest
import Combine
@testable import StarWarsBrowser

class NetworkServiceTests: XCTestCase {
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }()
    private lazy var networkService = NetworkService(session: session)
    private let resource = Resource<CategoriesDTO>.categories()
    private lazy var categoriesJsonData: Data = {
        let url = Bundle(for: NetworkServiceTests.self).url(forResource: "Categories", withExtension: "json")
        guard let resourceUrl = url, let data = try? Data(contentsOf: resourceUrl) else {
            XCTFail("Failed to create data object from string!")
            return Data()
        }
        return data
    }()
    private var cancellables: [AnyCancellable] = []

    override class func setUp() {
        URLProtocol.registerClass(URLProtocolMock.self)
    }
    
    func test_load_succeeds() {
        // Given
        var result: Result<CategoriesDTO, Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.resource.url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.categoriesJsonData)
        }
        
        // When
        networkService.load(resource)
            .map({ categories -> Result<CategoriesDTO, Error> in Result.success(categories) })
            .catch({ error -> AnyPublisher<Result<CategoriesDTO, Error>, Never> in .just(.failure(error)) })
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
            }).store(in: &cancellables)
               
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .success(let categories) = result else {
            XCTFail()
            return
        }
        XCTAssertEqual(categories.items.count, 6)
    }
    
    func test_load_fails_withInternalError() {
        // Given
        var result: Result<CategoriesDTO, Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.resource.url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        // When
        networkService.load(resource)
            .map({ categories -> Result<CategoriesDTO, Error> in Result.success(categories) })
            .catch({ error -> AnyPublisher<Result<CategoriesDTO, Error>, Never> in .just(.failure(error)) })
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
            }).store(in: &cancellables)
               
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure(let error) = result,
            let networkError = error as? NetworkError,
            case NetworkError.dataLoadingError(500, _) = networkError else {
                XCTFail()
            return
        }
    }
    
    func test_load_fails_withJsonParsingError() {
        // Given
        var result: Result<CategoriesDTO, Error>?
        let expectation = self.expectation(description: "networkServiceExpectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: self.resource.url, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }
        
        // When
        networkService.load(resource)
            .map({ categories -> Result<CategoriesDTO, Error> in Result.success(categories) })
            .catch({ error -> AnyPublisher<Result<CategoriesDTO, Error>, Never> in .just(.failure(error)) })
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
            }).store(in: &cancellables)
                    
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case .failure(let error) = result,
            let networkError = error as? NetworkError,
            case NetworkError.dataLoadingError(500, _) = networkError else {
                XCTFail()
            return
        }
    }
}
