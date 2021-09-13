//
//  ApplicationFlowCoordinatorDependencyProvider.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit

protocol ApplicationFlowCoordinatorDependencyProvider: CategoriesFlowCoordinatorDependencyProvider {}

protocol CategoriesFlowCoordinatorDependencyProvider: class {
    func categoriesNavigationController(navigator: CategoriesNavigator) -> UINavigationController
}
 
