//
//  MainSceneDependenciesContainer.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import UIKit

final class MainSceneDependenciesContainer {
    let categoriesDependencies: CategoriesDependencies
    let detailsDependencies: DetailsDependencies
    
    init(categoriesDependencies: CategoriesDependencies, detailsDependencies: DetailsDependencies) {
        self.categoriesDependencies = categoriesDependencies
        self.detailsDependencies = detailsDependencies
    }
        
    func mainFlowCoordinator(window: UIWindow) -> MainFlowCoordinator {
        MainFlowCoordinator(window: window, dependencyProvider: self)
    }
}

extension MainSceneDependenciesContainer: MainFlowCoordinatorDependencyProvider {
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController {
        let categoriesViewModel = CategoriesViewModel(useCase: categoriesDependencies.useCase, navigator: navigator)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        let detailsViewModel = DetailsViewModel(category: .unknown, useCase: detailsDependencies.useCase)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        
        let mainViewController = MainViewController(categoriesViewController, detailsViewController)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        return mainNavigationController
    }
    
    func detailsViewModel(for category: Category.T, url: URL) -> DetailsViewModel {
        return DetailsViewModel(category: category, url: url, useCase: detailsDependencies.useCase)
    }
}
