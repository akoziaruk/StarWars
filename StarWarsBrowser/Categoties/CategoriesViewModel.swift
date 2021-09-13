//
//  CategoriesViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine

class CategoriesViewModel: CategoriesViewModelType {
    
    private let useCase: CategoriesUseCaseType
    private weak var navigator: CategoriesNavigator?
    private var subscriptions = Set<AnyCancellable>()
    
    init(useCase: CategoriesUseCaseType, navigator: CategoriesNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: CategoriesViewModelInput) -> CategoriesViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let categories = input.load
            .flatMapLatest({ [unowned self] in self.useCase.loadCategories() })
            .map({ result -> CategoriesLoadingState in
                switch result {
                case .success(let categories) where categories.items.isEmpty: return .noResult
                case .success(let categories): return .success(self.viewModels(from: categories.items))
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        
        let initialState: CategoriesViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, categories).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func viewModels(from categories: [Category]) -> [CategoryViewModel] {
        return categories.compactMap { CategoryViewModel($0) }
    }
}
