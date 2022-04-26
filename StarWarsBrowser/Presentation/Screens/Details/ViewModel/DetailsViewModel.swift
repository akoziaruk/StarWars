//
//  DetailsViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import Foundation

class DetailsViewModel: DetailsViewModelType {
    private let category: Category.T
    private let url: URL?
    private let useCase: DetailsUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    private var page = 1
        
    init(category: Category.T, url: URL? = nil, useCase: DetailsUseCaseType) {
        self.category = category
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
                
        let details = input.loadNextPage
            .compactMap({ self.url })
            .flatMapLatest({ [unowned self] in
                self.useCase.loadDetails(url: $0, page: page, category: category)
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
                    print("debug: \(self.page)")
                }
            })
            .eraseToAnyPublisher()

        let initialState: DetailsViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, details).eraseToAnyPublisher()
    }

    private func viewModels(from details: [Detailable]) -> [AnyHashable] {
        return details.map {[unowned self] detail in
            DetailViewModelFactory.viewModel(from: detail, imageLoader: {[unowned self] detail in self.useCase.loadImage(for: detail, category: category)})
        }
    }
    
}
