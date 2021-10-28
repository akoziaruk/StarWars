//
//  CategoriesViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine
import Foundation

class CategoriesViewModel: CategoriesViewModelType {
    private let useCase: MainUseCaseType
    private weak var navigator: MainNavigator?
    private var subscriptions = Set<AnyCancellable>()
    private var selectedCategory = Category.T.film
    
    @Published private var error: Error?
    @Published private var categories = [CategoryViewModel]() {
        didSet {
            // load details data first time
            if oldValue.isEmpty, let first = categories.first {
                selectedCategory(with: first.type, url: first.url)
            }
        }
    }
    
    init(useCase: MainUseCaseType, navigator: MainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: CategoriesViewModelInput) -> CategoriesViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        input.load
            .flatMapLatest({ [unowned self] in self.useCase.loadCategories() })
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let categories): self.categories = viewModels(from: categories.items)
                case .failure(let error):      self.error = error
                }
            }).store(in: &subscriptions)
            
        input.select
            .sink(receiveValue: { [unowned self] item in
                self.selectedCategory(with: item.type, url: item.url)
            })
            .store(in: &subscriptions)
                
        let categoriesData: CategoriesViewModelOutput = $categories.map { values in .success(values) }
            .eraseToAnyPublisher()
        
        let error: CategoriesViewModelOutput = $error.compactMap { $0 }
            .map { error in .failure(error) }
            .eraseToAnyPublisher()
        
        let output: CategoriesViewModelOutput = Publishers.Merge(categoriesData, error).eraseToAnyPublisher()
        let initialState: CategoriesViewModelOutput = .just(.idle)

        return Publishers.Merge(initialState, output).removeDuplicates().eraseToAnyPublisher()
    }

    private func selectedCategory(with type: Category.T, url: URL) {
        self.selectedCategory = type
        self.navigator?.showCategory(for: type, url: url)
    }
    
    private func viewModels(from categories: [Category]) -> [CategoryViewModel] {
        return categories.compactMap { CategoryViewModel($0, selected: selectedCategory == $0.type) }
    }
    
}
