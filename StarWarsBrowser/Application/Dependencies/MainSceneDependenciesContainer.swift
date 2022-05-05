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
    var detailsViewModel: DetailsViewModel!
    
    init(categoriesDependencies: CategoriesDependencies, detailsDependencies: DetailsDependencies) {
        self.categoriesDependencies = categoriesDependencies
        self.detailsDependencies = detailsDependencies
    }
        
    func mainFlowCoordinator(window: UIWindow) -> MainFlowCoordinator {
        MainFlowCoordinator(window: window, dependencyProvider: self)
    }
}

extension MainSceneDependenciesContainer: MainFlowCoordinatorDependencyProvider {
    func showDetails(for category: SelectedCategory) {
        detailsViewModel.set(category)
    }
    
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController {
        let categoriesViewModel = CategoriesViewModel(useCase: categoriesDependencies.useCase, navigator: navigator)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        
        detailsViewModel = DetailsViewModel(useCase: detailsDependencies.useCase)
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        
        let mainViewController = MainViewController(categoriesViewController, detailsViewController)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        return mainNavigationController
    }
}
