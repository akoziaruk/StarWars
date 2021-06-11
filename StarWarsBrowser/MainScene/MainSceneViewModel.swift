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
    private var loadData: AnyPublisher<Void, Never> = PassthroughSubject<Void, Never>().eraseToAnyPublisher()
    
    // MARK: Output
    private var reloadPeopeListSubject = PassthroughSubject<[Person], Never>()
    
    var reloadPeopeList: AnyPublisher<[Person], Never> {
        reloadPeopeListSubject.eraseToAnyPublisher()
    }
    
    // MARK: Display data
    private var people = [Person]()
    
    func attachViewEventListener(loadData: AnyPublisher<Void, Never>) {
        self.loadData = loadData
        loadData
            .setFailureType(to: StarWarsAPIError.self)
            .flatMap { _ -> AnyPublisher<[Person], StarWarsAPIError> in
                let service = StarWarsNetworkService()
                return service.loadPeopeList()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:{ _ in },
                  receiveValue: { [weak self] people in
                    self?.people = people
                    self?.reloadPeopeListSubject.send(people)
            })
            .store(in: &subscriptions)

        
    }
    
}
