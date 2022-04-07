//
//  CategoriesViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine
import Foundation

class CategoriesViewModel: CategoriesViewModelType {
    private let useCase: CategoriesUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    private weak var navigator: MainNavigator?

    var selectedCategory: Category.T?
    
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
                case .success(let categories): return .success(self.viewModels(from: categories.sorted()))
                case .failure(let error): return .failure(error)
                }
            })
            .handleEvents(receiveOutput: { state in
                // on start show first category details
                guard case .success(let categories) = state,
                      let first = categories.first,
                      self.selectedCategory == nil else { return }
                    
                self.selectCategory(with: first.type, url: first.url)
            })
            .eraseToAnyPublisher()

        input.select
            .sink(receiveValue: { [unowned self] item in
                self.selectCategory(with: item.type, url: item.url)
            })
            .store(in: &subscriptions)

        let initialState: CategoriesViewModelOutput = .just(.idle)

        return Publishers.Merge(initialState, categories).removeDuplicates().eraseToAnyPublisher()
    }

    private func selectCategory(with type: Category.T, url: URL) {
        self.selectedCategory = type
        self.navigator?.showCategory(for: type, url: url)
    }
    
    private func viewModels(from categories: [Category]) -> [CategoryViewModel] {
        categories.map { CategoryViewModel($0, selected: (selectedCategory ?? .film) == $0.type) }
    }
    
}
