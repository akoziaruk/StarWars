//
//  CoreDataDetailsStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation
import CoreData
import Combine

class CoreDataDetailsStorage {
    var coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
    private func fetchRequest() -> NSFetchRequest<PersistentDetail> {
        return PersistentDetail.fetchRequest()
    }
}

extension CoreDataDetailsStorage: DetailsStorage {
    func getDetails() -> AnyPublisher<[Detailable], Error> {
        coreDataStorage
            .fetch(request: fetchRequest())
            .map { $0.map { $0.toDTO() } }
            .eraseToAnyPublisher()
    }
}

extension PersistentDetail {
    func toDTO() -> Сharacter {
        Сharacter(name: name!)
    }
}
