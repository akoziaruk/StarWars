//
//  DataStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import Combine
import Firebase
import FirebaseStorageCombineSwift
    
class DataStorage: DataStorageType {
    func loadData(for url: String) -> AnyPublisher<Data, Error> {
        Storage.storage()
            .reference(forURL: url)
            .getData(maxSize: Constants.maxSize)
            .eraseToAnyPublisher()
    }

    struct Constants {
        static let maxSize = 1 * 1024 * 1024 as Int64
    }
}
