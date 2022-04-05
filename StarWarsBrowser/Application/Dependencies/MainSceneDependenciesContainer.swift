//
//  MainSceneDependenciesContainer.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import UIKit

final class MainSceneDependenciesContainer {
    
    let networkService: NetworkService
    let imageLoaderService: ImageLoaderServiceType
    
    init(networkService: NetworkService, imageLoaderService: ImageLoaderServiceType) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
        
    var categoriesStorage: CategoriesStorage = CoreDataCategoriesStorage()
        
    private func categoriesRepository() -> CategoriesRepositoryType {
        CategoriesRepository(networkService: networkService, storage: categoriesStorage)
    }
        
    private func categoriesUseCase() -> CategoriesUseCaseType {
        return CategoriesUseCase(categoriesRepository: categoriesRepository())
    }
    private func detailsUseCase() -> MainUseCaseType {
        return MainUseCase()
    }
        
    func mainFlowCoordinator(window: UIWindow) -> MainFlowCoordinator {
        MainFlowCoordinator(window: window, dependencyProvider: self)
    }
    
}

extension MainSceneDependenciesContainer: MainFlowCoordinatorDependencyProvider {
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController {

        let categoriesViewModel = CategoriesViewModel(useCase: categoriesUseCase(), navigator: navigator)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)

        let detailsViewModel = DetailsViewModel(category: .unknown, useCase: detailsUseCase())
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)

        let mainViewController = MainViewController(categoriesViewController, detailsViewController)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)

        return mainNavigationController
    }
    
    func detailsViewModel(for category: Category.T, url: URL) -> DetailsViewModel {
        return DetailsViewModel(category: category, url: url, useCase: detailsUseCase())
    }
}
