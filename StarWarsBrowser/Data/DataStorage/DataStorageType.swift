//
//  DataLoaderType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import Combine

protocol DataStorageType {
    func loadData(for url: String) -> AnyPublisher<Data, Error>
}
