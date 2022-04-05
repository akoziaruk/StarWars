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
    private let useCase: MainUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    private var page = 1
        
    init(category: Category.T, url: URL? = nil, useCase: MainUseCaseType) {
        self.category = category
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
                
        let details = input.loadNextPage
            .compactMap({ self.url })
            .flatMap(maxPublishers: .max(1), { [unowned self] in self.useCase.loadDetails(url: $0, page: self.page, category: self.category) })
            .map({ result -> DetailsLoadingState in
                switch result {
                case .success(let details) where details.isEmpty: return .noResult
                case .success(let details): return .success(self.viewModels(from: details))
                case .failure(let error): return .failure(error)
                }
            })
            .handleEvents(receiveOutput: { state in
                if case .success(_) = state {
                    self.page = self.page + 1
                }
            })
            .eraseToAnyPublisher()

        let initialState: DetailsViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, details).removeDuplicates().eraseToAnyPublisher()
    }

    private func viewModels(from details: [Detailable]) -> [AnyHashable] {
        details.map {[unowned self] detail in
            DetailViewModelFactory.viewModel(from: detail, imageLoader: {[unowned self] detail in self.useCase.loadImage(for: detail)})
        }
    }
    
}
