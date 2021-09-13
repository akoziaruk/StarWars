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
        
        let detailsViewController = detailsViewController(categoryId: nil)
        
        let mainViewController = MainViewController(categoriesViewController, detailsViewController)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        
        return mainNavigationController
    }
    
    func detailsViewController(categoryId: String?) -> DetailsViewController {
        let viewModel = DetailsViewModel(useCase: useCase)
        return DetailsViewController(viewModel: viewModel)
    }
}
