//
//  PersistanceDataServiceType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import Combine
import CoreData

protocol PersistanceDataServiceType: AnyObject {
    func fetch<T: NSManagedObject>(_ type: T.Type) -> AnyPublisher<[T], Error>
    func add<T: NSManagedObject>(_ type: T.Type, body: @escaping (inout T) -> Void)
    func save()
}
