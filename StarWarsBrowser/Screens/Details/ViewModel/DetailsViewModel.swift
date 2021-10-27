//
//  DetailsViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import UIKit

class DetailsViewModel: DetailsViewModelType {
    private let type: Category.T
    private let url: URL?
    private let useCase: MainUseCaseType
    private var subscriptions = Set<AnyCancellable>()
    
    init(type: Category.T, url: URL? = nil, useCase: MainUseCaseType) {
        self.type = type
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        let details = input.load
            .flatMapLatest({ [unowned self] in self.loadDetails() })
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
    
    private func loadDetails() -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
        guard let url = self.url else { return .just(.failure(UseCaseError.unknownType)) }
        
        switch type {
        case .film:
            return useCase.loadDetails(url: url, type: Film.self)
        case .people:
            return useCase.loadDetails(url: url, type: People.self)
        case .planet:
            return useCase.loadDetails(url: url, type: Planet.self)
        case .species:
            return .just(.failure(UseCaseError.unknownType))
        case .starship:
            return .just(.failure(UseCaseError.unknownType))
        case .vehicle:
            return .just(.failure(UseCaseError.unknownType))
        case .unknown:
            return .just(.failure(UseCaseError.unknownType))
        }
    }
}
