//
//  ApplicationFlowCoordinator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

class ApplicationFlowCoordinator {
    private let window: UIWindow
    private let dependencyProvider: AppDependenciesContainer
    private var flowCoordinator: MainFlowCoordinator!
    
    init(window: UIWindow, dependencyProvider: AppDependenciesContainer) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        let dependenciesContainer = dependencyProvider.mainSceneDependenciesContainer()
        flowCoordinator = dependenciesContainer.mainFlowCoordinator(window: window)
        flowCoordinator.start()
    }
}
