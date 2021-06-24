//
//  MainSceneViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 10.06.2021.
//

import Foundation
import Combine

class MainSceneViewModel {
    private var subscriptions = Set<AnyCancellable>()
        
    // MARK: Input
    private var loadCategoriesData = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    private var loadInfoData = PassthroughSubject<Int, Never>().eraseToAnyPublisher()

    // MARK: Output
    private var reloadCategoriesSubject = PassthroughSubject<[CategoryViewModel], Never>()
    private var reloadDetailsSubject = PassthroughSubject<[DetailsViewModel], Never>()

    var reloadCategories: AnyPublisher<[CategoryViewModel], Never> {
        reloadCategoriesSubject.eraseToAnyPublisher()
    }
    
    var reloadDetails: AnyPublisher<[DetailsViewModel], Never> {
        reloadDetailsSubject.eraseToAnyPublisher()
    }
    
    // MARK: Display data
    private var categories = [CategoryViewModel]()
    private var details = [DetailsViewModel]()

    func attachViewEventListener(loadCategoriesData: AnyPublisher<Void, Never>) {
        self.loadCategoriesData = loadCategoriesData
        loadCategoriesData
            .setFailureType(to: StarWarsAPIError.self)
            .flatMap { _ -> AnyPublisher<[Category], StarWarsAPIError> in
                let service = NetworkService()
                return service.loadCategories()
            }
            .map { self.categoryViewModels(from: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ _ in },
                  receiveValue: { [weak self] categories in
                    self?.categories = categories
                    self?.reloadCategoriesSubject.send(categories)
            })
            .store(in: &subscriptions)        
    }
    
    func attachViewEventListener(loadDetailsData: AnyPublisher<Int, Never>) {
        self.loadInfoData = loadDetailsData
        loadDetailsData
            .setFailureType(to: StarWarsAPIError.self)
            .compactMap { self.categories[$0].url }
            .flatMap { url -> AnyPublisher<[DetailType], StarWarsAPIError> in
                let service = NetworkService()
                switch url.dataType {
                case .film:
                    return service.loadFilms(with: url)
                case .unknown:
                    return Fail(error: StarWarsAPIError.invalidURL).eraseToAnyPublisher()
                }
            }
            .map { self.detailViewModels(from: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ _ in },
                  receiveValue: { [weak self] details in
                    self?.details = details
                    self?.reloadDetailsSubject.send(details)
            })
            .store(in: &subscriptions)
    }
    
    private func categoryViewModels(from categories: [Category]) -> [CategoryViewModel] {
        return categories.compactMap { CategoryViewModel($0) }
    }
    
    private func detailViewModels(from details: [DetailType]) -> [DetailsViewModel] {
        return details.compactMap { ViewModelBuilder.viewModel(from: $0) }
    }
}
