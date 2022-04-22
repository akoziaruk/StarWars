//
//  AppDependenciesContainer.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

final class AppDependenciesContainer {
    private let networkService: NetworkServiceType = NetworkService()

    func mainSceneDependenciesContainer() -> MainSceneDependenciesContainer {
        let categoriesDependencies = CategoriesDependencies(network: networkService)
        let detailsDependencies = DetailsDependencies(network: networkService)
        
        return MainSceneDependenciesContainer(categoriesDependencies: categoriesDependencies,
                                              detailsDependencies: detailsDependencies)
    }
}
