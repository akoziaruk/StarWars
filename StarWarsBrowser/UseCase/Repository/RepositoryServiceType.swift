//
//  DataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

protocol RepositoryServiceType: AnyObject {
    func loadCategories() -> AnyPublisher<[Category], Error>    
}
