//
//  CategoriesFlowCoordinator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

class CategoriesFlowCoordinator: FlowCoordinator {
    fileprivate let window: UIWindow
    fileprivate var navigationController: UINavigationController?
    fileprivate let dependencyProvider: CategoriesFlowCoordinatorDependencyProvider
    
    init(window: UIWindow, dependencyProvider: CategoriesFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        navigationController = dependencyProvider.categoriesNavigationController(navigator: self)
        window.rootViewController = navigationController
    }
}

extension CategoriesFlowCoordinator: CategoriesNavigator {
    //TODO: Add navigaton here
}
