//
//  ApplicationComponentsFactory.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

final class ApplicationComponentsFactory {
    fileprivate lazy var useCase: CategoriesUseCaseType = CategoriesUseCase(networkService: servicesProvider.network)

    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func categoriesNavigationController(navigator: CategoriesNavigator) -> UINavigationController {
        let viewModel = CategoriesViewModel(useCase: useCase, navigator: navigator)
        let categoriesViewController = CategoriesViewController(viewModel: viewModel)
        let categoriesNavigationController = UINavigationController(rootViewController: categoriesViewController)
        return categoriesNavigationController
    }
}
