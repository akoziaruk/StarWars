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
    private var page = 1
    
    @Published var detailsViewModels = [DetailViewModel]()
    
    @Published var error: Error?
    @Published var details = [DetailViewModel]()
    
    init(type: Category.T, url: URL? = nil, useCase: MainUseCaseType) {
        self.type = type
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        input.loadNextPage
            .compactMap({ [unowned self] in self.url })
            .flatMap(maxPublishers: .max(1), { [unowned self] in self.useCase.loadDetails(url: $0, page: self.page, type: self.type) })
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let details): let viewModels = DetailViewModelFactory.viewModels(from: details)
                                            self.details.append(contentsOf: viewModels)
                                            page = page + 1
                    
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
        
        return Publishers.Merge(initialState, output).removeDuplicates().eraseToAnyPublisher()
    }

    private func loadDetails() {
        
    }
    
}
