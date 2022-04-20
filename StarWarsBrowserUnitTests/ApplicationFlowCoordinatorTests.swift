//
//  ApplicationFlowCoordinatorTests.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//

import XCTest
@testable import StarWarsBrowser

class ApplicationFlowCoordinatorTests: XCTestCase {
    private let dependencyProvider = ApplicationFlowCoordinatorDependencyProviderMock()
    private let window = UIWindow()

    private lazy var flowCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: dependencyProvider)

    // Test that application flow is started correctly
    func test_startsApplicationsFlow() {
        // Given
        let rootViewController = UINavigationController()
        dependencyProvider.mainNavigationControllerReturnValue = rootViewController

        // When
        flowCoordinator.start()

        // Then
        XCTAssertEqual(window.rootViewController, rootViewController)
    }

}
