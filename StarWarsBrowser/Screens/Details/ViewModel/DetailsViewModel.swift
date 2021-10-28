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
    private var state = DetailsLoadingState.idle
    
    @Published var detailsViewModels = [DetailViewModelType]() {
        didSet {
            let i = oldValue
        }
    }
    
    init(type: Category.T, url: URL? = nil, useCase: MainUseCaseType) {
        self.type = type
        self.url = url
        self.useCase = useCase
    }

    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()

        input.loadNextPage
            .compactMap({ [unowned self] _ in self.url })
            .flatMapLatest({ [unowned self] in self.useCase.loadDetails(url: $0, page: page, type: type) })
            .sink(receiveValue: { [unowned self] result in
                switch result {
                case .success(let details):
                    let detailsVM = DetailViewModelFactory.viewModels(from: details.items)
                    self.detailsViewModels = detailsVM
//                    self.details = details
                case .failure(let error):   break
                }
            }).store(in: &subscriptions)
        
        let detailsData: DetailsViewModelOutput = $detailsViewModels.map { values in
            .success(values)
        }.eraseToAnyPublisher()
        
//            .map({ result -> DetailsLoadingState in
//                switch result {
//                case .success(let details) where details.items.isEmpty: return .noResult
//                case .success(let details): return .success(DetailViewModelFactory.viewModels(for: details.items))
//                case .failure(let error): return .failure(error)
//                }
//            })
        
//        details.sink { [unowned self] result in
//                switch result {
//                case .success(_): self.page = self.page + 1
//                default: break
//                }
//        }.store(in: &subscriptions)
//
//        let loadedDetails = details
//            .eraseToAnyPublisher()
        
        let initialState: DetailsViewModelOutput = .just(.idle)
        
        return Publishers.Merge(initialState, detailsData).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func loadDetails() {
        
    }
    
}
