//
//  DetailsViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine

class DetailsViewModel: DetailsViewModelType {
        
    private let useCase: MainUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    
    init(useCase: MainUseCaseType) {
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        let details = input.selection
            .flatMapLatest({ [unowned self] in self.useCase.loadDetails(type: $0, url: $1) })
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
