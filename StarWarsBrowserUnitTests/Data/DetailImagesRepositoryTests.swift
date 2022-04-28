//
//  DetailImagesRepositoryTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import XCTest
import Foundation
import Combine
@testable import StarWarsBrowser

class DetailImagesRepositoryTests: XCTestCase {
    private let cache = ImageCacheMock()
    private let storage = DataStorageMock()
    private var repository: DetailImagesRepository!
    private var cancellables: [AnyCancellable] = []
    private let detail = DefaultDetail(name: "Luke Skywalker")
    private let category: Category.T = .people
    
    override func setUp() {
        super.setUp()
        
        repository = DetailImagesRepository(cache: cache, storage: storage)
    }
        
    func test_loadImage_fromCache_succeeds() {
        //Given
        var result: UIImage!

        let expectation = self.expectation(description: "image")
        let path = detail.storagePath(for: category)!
        cache[path] = UIImage()
        
        // When
        repository
            .loadImage(for: detail, category: category)
            .sink {
                result = $0
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
    
    func test_loadImage_fromStorage_succeeds() {
        //Given
        var result: UIImage!

        let expectation = self.expectation(description: "image")
        let path = detail.storagePath(for: category)!
        storage.responses[path] = UIImage(named: "people")?.pngData()

        // When
        repository
            .loadImage(for: detail, category: category)
            .sink {
                result = $0
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
    
    func test_loadImage_loadedImageInCache_succeeds() {
        //Given
        var result: UIImage!

        let expectation = self.expectation(description: "image")
        let path = detail.storagePath(for: category)!
        storage.responses[path] = UIImage(named: "people")?.pngData()

        // When
        repository
            .loadImage(for: detail, category: category)
            .sink { _ in }
            .store(in: &cancellables)
        
        result = cache.image(for: path)
        expectation.fulfill()

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(result)
    }
    
    func test_loadImage_fails() {
        //Given
        var result: UIImage!
        let expectation = self.expectation(description: "image")

        // When
        repository
            .loadImage(for: detail, category: category)
            .sink {
                result = $0
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNil(result)
    }
}
