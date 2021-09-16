//
//  DetailsViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import UIKit

class DetailsViewModel: DetailsViewModelType {
        
    private let url: URL?
    private let useCase: MainUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    
    init(url: URL? = nil, useCase: MainUseCaseType) {
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        let details = input.load
            .compactMap { [unowned self] _ in self.url }
            .flatMapLatest({ [unowned self] in self.useCase.loadDetails(url: $0) })
            .map({ result -> DetailsLoadingState in
                switch result {
                case .success(let details) where details.items.isEmpty: return .noResult
                case .success(let details): return .success(DetailViewModelFactory.viewModels(for: details.items))
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        
        let initialState: DetailsViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, details).removeDuplicates().eraseToAnyPublisher()
    }
}
