//
//  ApplicationComponentsFactory.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

final class ApplicationComponentsFactory {
    fileprivate lazy var useCase: MainUseCaseType = MainUseCase(networkService: servicesProvider.network)

    private let servicesProvider: ServicesProvider

    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider()) {
        self.servicesProvider = servicesProvider
    }
}

extension ApplicationComponentsFactory: ApplicationFlowCoordinatorDependencyProvider {
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController {
        let categoriesViewModel = CategoriesViewModel(useCase: useCase, navigator: navigator)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        let detailsViewModel = DetailsViewModel(type: .unknown, useCase: useCase)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        
        let mainViewController = MainViewController(categoriesViewController, detailsViewController)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        
        return mainNavigationController
    }
    
    func detailsViewModel(for type: CategoryType, url: URL) -> DetailsViewModel {
        return DetailsViewModel(type: type, url: url, useCase: useCase)
    }
}
