//
//  CategoriesRepositoryTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import XCTest
import Foundation
import Combine
@testable import StarWarsBrowser

class CategoriesRepositoryTests: XCTestCase {
    private var network = NetworkServiceMock()
    private var storage = CategoriesStorageMock()
    private var repository: CategoriesRepository!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        super.setUp()
        
        repository = CategoriesRepository(network: network, storage: storage)
    }
    
    func test_fetchCategories_succeeds() {
        //Given
        var result: [Category]!
        let expectation = self.expectation(description: "categories")
        expectation.expectedFulfillmentCount = 2
        
        let categoriesDTO = CategoriesDTO.loadFromFile("Categories.json", target: Self.self)
        network.responses["/api"] = categoriesDTO
        storage.requestAllReturnValue = .just(categoriesDTO)

        let expectedCategories = categoriesDTO.toDomain()

        // When
        repository
            .fetchCategories()
            .sink(receiveCompletion: { _ in }, receiveValue: { categories in
                result = categories
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(result!, expectedCategories)
    }
}
