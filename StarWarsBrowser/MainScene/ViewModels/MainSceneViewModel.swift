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
    private var reloadCategoriesSubject = PassthroughSubject<[Category], Never>()
    private var reloadDetailsSubject = PassthroughSubject<Details, Never>()

    var reloadCategories: AnyPublisher<[Category], Never> {
        reloadCategoriesSubject.eraseToAnyPublisher()
    }
    
    var reloadDetails: AnyPublisher<Details, Never> {
        reloadDetailsSubject.eraseToAnyPublisher()
    }
    
    // MARK: Display data
    private var categories = [Category]()
    private var details: Details?

    func attachViewEventListener(loadCategoriesData: AnyPublisher<Void, Never>) {
        self.loadCategoriesData = loadCategoriesData
        loadCategoriesData
            .setFailureType(to: StarWarsAPIError.self)
            .flatMap { _ -> AnyPublisher<[Category], StarWarsAPIError> in
                let service = StarWarsNetworkService()
                return service.loadCategories()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ _ in },
                  receiveValue: { [weak self] categories in
                    self?.categories = categories
                    self?.reloadCategoriesSubject.send(categories)
            })
            .store(in: &subscriptions)        
    }
    
    func attachViewEventListener(loadInfoData: AnyPublisher<Int, Never>) {
        self.loadInfoData = loadInfoData
        loadInfoData
            .setFailureType(to: StarWarsAPIError.self)
            .compactMap { self.categories[$0].url }
            .flatMap { url -> AnyPublisher<Details, StarWarsAPIError> in
                let service = StarWarsNetworkService()
                return service.loadDetailsFor(url)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ _ in },
                  receiveValue: { [weak self] details in
                    self?.details = details
                    self?.reloadDetailsSubject.send(details)
            })
            .store(in: &subscriptions)
    }
}
