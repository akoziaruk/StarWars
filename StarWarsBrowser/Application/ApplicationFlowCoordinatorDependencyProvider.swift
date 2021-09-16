//
//  ApplicationFlowCoordinatorDependencyProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

protocol ApplicationFlowCoordinatorDependencyProvider: MainFlowCoordinatorDependencyProvider {}

protocol MainFlowCoordinatorDependencyProvider: class {
    func mainNavigationController(navigator: MainNavigator) -> UINavigationController
    func detailsViewModel(for url: URL) -> DetailsViewModel
}
 
