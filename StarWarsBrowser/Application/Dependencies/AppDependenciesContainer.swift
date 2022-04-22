//
//  AppDependenciesContainer.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

final class AppDependenciesContainer {
    private let networkService: NetworkServiceType = NetworkService()
    private let imageLoader: ImageLoaderServiceType = ImageLoaderService()

    func mainSceneDependenciesContainer() -> MainSceneDependenciesContainer {
        let categoriesDependencies = CategoriesDependencies(network: networkService)
        let detailsDependencies = DetailsDependencies(network: networkService,
                                                      imageLoader: imageLoader)
        
        return MainSceneDependenciesContainer(categoriesDependencies: categoriesDependencies,
                                              detailsDependencies: detailsDependencies)
    }
}
