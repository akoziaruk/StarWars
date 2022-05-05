//
//  DetailsViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import Foundation

class DetailsViewModel: DetailsViewModelType {
    private let useCase: DetailsUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    private var categoryPublisher = CurrentValueSubject<SelectedCategory?, Never>(nil)
    private var page = 1

    init(useCase: DetailsUseCaseType) {
        self.useCase = useCase
    }
    
    func set(_ category: SelectedCategory) {
        page = 1
        categoryPublisher.send(category)
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        let loadDetails = categoryPublisher
            .combineLatest(input.loadNextPage)
            .compactMap { $0.0 }
            .flatMapLatest({ [unowned self] in
                self.useCase.loadDetails(url: $0.url, page: page, category: $0.type)
            })
            .map({ result -> DetailsLoadingState in
                switch result {
                case .success(let details) where details.isEmpty: return .noResult
                case .success(let details): return .success(self.viewModels(from: details))
                case .failure(let error): return .failure(error)
                }
            })
            .removeDuplicates()
            .handleEvents(receiveOutput: { state in
                if case .success(_) = state {
                    self.page = self.page + 1
                }
            })
            .eraseToAnyPublisher()
        
        let newCategoryDetails = categoryPublisher
            .map { _ in  DetailsLoadingState.prepareForReuse }
            .eraseToAnyPublisher()
                
        return Publishers.Merge(loadDetails, newCategoryDetails).eraseToAnyPublisher()
    }

    private func viewModels(from details: [Detailable]) -> [AnyHashable] {
        guard let type = categoryPublisher.value?.type else { return [] }
        
        return details.map {[unowned self] detail in
            DetailViewModelFactory.viewModel(from: detail, imageLoader: {[unowned self] detail in self.useCase.loadImage(for: detail, category: type)})
        }
    }
    
}
