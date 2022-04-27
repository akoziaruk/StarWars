//
//  DetailsRepositoryTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import XCTest
import Foundation
import Combine
@testable import StarWarsBrowser

class DetailsRepositoryTests: XCTestCase {
    private let network = NetworkServiceMock()
    private let storage = DetailsStorageMock()
    private var repository: DetailsRepository!
    private var cancellables: [AnyCancellable] = []

    override func setUp() {
        super.setUp()
        
        repository = DetailsRepository(network: network, storage: storage)
    }
    
    func test_loadDefaultDetails_succeeds() {
        //Given
        var result: [DefaultDetail]!
        
        let expectation = self.expectation(description: "people")
        expectation.expectedFulfillmentCount = 2
        
        let detailsDTO = DefaultDetailsDTO.loadFromFile("People.json", target: Self.self)
        network.responses["/api/people"] = detailsDTO
        storage.requestDefaultDetailsReturnValue = .just(detailsDTO)
        
        let expectedDetails = detailsDTO.toDomain()
        let url = APIConstants.baseURL.appendingPathComponent("people")

        // When
        repository
            .fetchDefaultDetails(url: url, page: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { details in
                result = details as? [DefaultDetail]
                expectation.fulfill()
            })
            .store(in: &cancellables)
                   
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(result!, expectedDetails)
    }

    func test_loadDefaultDetails_failed() {
        var error: ErrorMock!
        let expectation = self.expectation(description: "people")
        let url = APIConstants.baseURL.appendingPathComponent("people")

        storage.requestDefaultDetailsReturnValue = .fail(ErrorMock())

        repository
            .fetchDefaultDetails(url: url, page: 1)
            .sink(receiveCompletion: { completion in
                guard case .failure(let e) = completion else { return }
                error = e as? ErrorMock
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(error)
    }
        
    func test_loadFilmDetails_succeeds() {
        //Given
        var result: [Film]!
        
        let expectation = self.expectation(description: "films")
        expectation.expectedFulfillmentCount = 2
        
        let filmsDTO = FilmDetailsDTO.loadFromFile("Films.json", target: Self.self, decoder: FilmsDecoder())
        network.responses["/api/films"] = filmsDTO
        storage.requestFilmDetailsReturnValue = .just(filmsDTO)
        
        let expectedDetails = filmsDTO.toDomain()
        let url = APIConstants.baseURL.appendingPathComponent("films")

        // When
        repository
            .fetchFilms(url: url, page: 1)
            .sink(receiveCompletion: { _ in }, receiveValue: { films in
                result = films as? [Film]
                expectation.fulfill()
            })
            .store(in: &cancellables)
                   
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(result!, expectedDetails)
    }
        
    func test_loadFilmDetails_failed() {
        var error: ErrorMock!
        let expectation = self.expectation(description: "films")
        let url = APIConstants.baseURL.appendingPathComponent("films")

        storage.requestFilmDetailsReturnValue = .fail(ErrorMock())

        repository
            .fetchFilms(url: url, page: 1)
            .sink(receiveCompletion: { completion in
                guard case .failure(let e) = completion else { return }
                error = e as? ErrorMock
                expectation.fulfill()
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertNotNil(error)
    }
}
