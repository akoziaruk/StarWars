//
//  DataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

protocol DataProviderServiceType: AnyObject {

//    @discardableResult
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error>
    func loadCategories() -> AnyPublisher<Categories, Error>

}
