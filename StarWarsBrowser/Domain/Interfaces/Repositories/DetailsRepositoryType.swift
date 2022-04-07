//
//  DataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine

protocol DetailsRepositoryType: AnyObject {
    func fetchDetails() -> AnyPublisher<[Detailable], Error>
    
}
