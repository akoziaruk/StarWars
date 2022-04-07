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
    
    private func fetchRequest(for requestDTO: DetailsRequestDTO) -> NSFetchRequest<PersistentDetail> {
        // TODO: add parameters
        return PersistentDetail.fetchRequest()
    }
}

extension CoreDataDetailsStorage: DetailsStorage {
    func request(for requestDTO: DetailsRequestDTO) -> AnyPublisher<DetailableDTO, Error> {
        coreDataStorage
            .fetch(request: fetchRequest(for: requestDTO))
            .map { $0.toDTO(requestDTO.type) }
            .eraseToAnyPublisher()
    }
    
//    func getDetails() -> AnyPublisher<[Detailable], Error> {
//        coreDataStorage
//            .fetch(request: fetchRequest(for: <#DetailsRequestDTO#>))
//            .map { $0.map { $0.toDTO() } }
//            .eraseToAnyPublisher()
//    }
}

extension PersistentDetail {
    func toDTO() -> Сharacter {
        Сharacter(name: name!)
    }
}
