//
//  File.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//

import Foundation
import XCTest
import Combine
@testable import StarWarsBrowser

class MainUseCaseTypeMock: MainUseCaseType {
    // Load Categories
    var loadCategoriesCallsCount = 0
    var loadCategoriesCalled: Bool {
        return loadCategoriesCallsCount > 0
    }
    var loadCategoriesReturnValue: AnyPublisher<Result<Categories, Error>, Never>!
    var loadCategoriesClosure: (() -> AnyPublisher<Result<Categories, Error>, Never>)?

    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        loadCategoriesCallsCount += 1
        return loadCategoriesClosure.map({ $0() }) ?? loadCategoriesReturnValue
    }
    
    // Load Details
    var loadDetailsCallsCount = 0
    var loadDetailsCalled: Bool {
        return loadDetailsCallsCount > 0
    }
    var loadDetailsReceivedArguments: (url: URL, page: Int, category: StarWarsBrowser.Category.T)?
    var loadDetailsReceivedInvocations: [(url: URL, page: Int, category: StarWarsBrowser.Category.T)] = []
    var loadDetailsReturnValue: AnyPublisher<Result<[Detail], Error>, Never>!
    var loadDetailsClosure: ((URL, Int, StarWarsBrowser.Category.T) -> AnyPublisher<Result<[Detail], Error>, Never>)?
    
    func loadDetails(url: URL, page: Int, category: StarWarsBrowser.Category.T) -> AnyPublisher<Result<[Detail], Error>, Never> {
        loadDetailsCallsCount += 1
        loadDetailsReceivedArguments = (url: url, page: page, category: category)
        loadDetailsReceivedInvocations.append((url: url, page: page, category: category))
        return loadDetailsClosure.map({ $0(url, page, category) }) ?? loadDetailsReturnValue
    }
    
    // Load Image
    
    var loadImageCallsCount = 0
    var loadImageCalled: Bool {
        return loadImageCallsCount > 0
    }
    var loadImageReceivedDetail: Detail?
    var loadImageReceivedInvocations: [Detail] = []
    var loadImageReturnValue: AnyPublisher<UIImage?, Never>!
    var loadImageClosure: ((Detail) -> AnyPublisher<UIImage?, Never>)?

    func loadImage(for detail: Detail) -> AnyPublisher<UIImage?, Never> {
        loadImageCallsCount += 1
        loadImageReceivedDetail = detail
        loadImageReceivedInvocations.append(detail)
        return loadImageClosure.map({ $0(detail) }) ?? loadImageReturnValue
    }
}

class MainNavigatorMock: MainNavigator {
    var showCategoryCallsCount = 0
    var showCategoryCalled: Bool {
        return showCategoryCallsCount > 0
    }
    
    var showCategoryReceivedArguments: (type: StarWarsBrowser.Category.T, url: URL)?
    var showCategoryReceivedInvocations: [(type: StarWarsBrowser.Category.T, url: URL)] = []
    var showCategoryClosure: ((StarWarsBrowser.Category.T, URL) -> Void)?

    func showCategory(for type: StarWarsBrowser.Category.T, url: URL) {
        showCategoryCallsCount += 1
        showCategoryReceivedArguments = (type: type, url: url)
        showCategoryReceivedInvocations.append((type: type, url: url))
        showCategoryClosure?(type, url)
    }
}

class ApplicationFlowCoordinatorDependencyProviderMock: ApplicationFlowCoordinatorDependencyProvider {
    var mainNavigationControllerReturnValue: UINavigationController?
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController {
        return mainNavigationControllerReturnValue!
    }
    var detailsViewModelReturnValue: DetailsViewModel?
    func detailsViewModel(for category: StarWarsBrowser.Category.T, url: URL) -> DetailsViewModel {
        return detailsViewModelReturnValue!
    }
}
