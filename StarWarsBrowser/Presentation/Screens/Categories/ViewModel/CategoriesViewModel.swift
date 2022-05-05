//
//  CategoriesViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine
import Foundation

class CategoriesViewModel: CategoriesViewModelType {
    private struct Default {
        static let category = Category.T.films
    }
    private let useCase: CategoriesUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    private weak var navigator: MainNavigator?
    private var selected: Category.T?
    
    init(useCase: CategoriesUseCaseType, navigator: MainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: CategoriesViewModelInput) -> CategoriesViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let categories = input.load
            .flatMap({ [unowned self] in self.useCase.loadCategories() })
            .map({ result -> CategoriesLoadingState in
                switch result {
                case .success(let categories) where categories.isEmpty: return .noResult
                case .success(let categories): return .success(self.viewModels(from: categories))
                case .failure(let error): return .failure(error)
                }
            })
            .handleEvents(receiveOutput: { state in
                // on start show first category details
                guard case .success(let categories) = state,
                      let category = categories.filter({ $0.type == Default.category }).first,
                      self.selected == nil else { return }
                    
                self.select(SelectedCategory(type: category.type, url: category.url))
            })
            .eraseToAnyPublisher()

        input.select
            .sink(receiveValue: { [unowned self] category in
                self.select(category)
            })
            .store(in: &subscriptions)

        let initialState: CategoriesViewModelOutput = .just(.idle)

        return Publishers.Merge(initialState, categories).removeDuplicates().eraseToAnyPublisher()
    }

    private func select(_ category: SelectedCategory) {
        self.selected = category.type
        self.navigator?.show(category)
    }
    
    private func viewModels(from categories: [Category]) -> [CategoryViewModel] {
        categories.map { CategoryViewModel($0, selected: (selected ?? Default.category) == $0.type) }
    }
}
