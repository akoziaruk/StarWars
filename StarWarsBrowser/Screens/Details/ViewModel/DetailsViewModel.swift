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
    
    @Published var error: Error?
    @Published var details = [DetailViewModelType]()
    
    init(type: Category.T, url: URL? = nil, useCase: MainUseCaseType) {
        self.type = type
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        input.load
            .compactMap({ [unowned self] in self.url })
            .flatMapLatest({ [unowned self] in self.useCase.loadDetails(url: $0, type: self.type) })
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let details): self.details = DetailViewModelFactory.viewModels(from: details.items)
                case .failure(let error):   self.error = error
                }
            }).store(in: &subscriptions)
        
        let detailsData: DetailsViewModelOutput = $details.map { values in
            .success(values)
        }.eraseToAnyPublisher()
        
        let error: DetailsViewModelOutput = $error.compactMap { $0 }
            .map { error in .failure(error) }
            .eraseToAnyPublisher()

        let output: DetailsViewModelOutput = Publishers.Merge(detailsData, error).eraseToAnyPublisher()
        let initialState: DetailsViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, output).eraseToAnyPublisher()
    }
    
}
