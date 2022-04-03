//
//  DataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

protocol RepositoryType: AnyObject {
    func loadCategories() -> AnyPublisher<[Category], Error>    
}
