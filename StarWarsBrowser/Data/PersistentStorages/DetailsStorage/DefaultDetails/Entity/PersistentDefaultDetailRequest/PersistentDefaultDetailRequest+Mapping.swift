//
//  PersistentDefaultDetailRequest+Mapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//

import Foundation
import CoreData

extension DefaultDetailsRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> PersistentDefaultDetailRequest {
        let entity = PersistentDefaultDetailRequest(context: context)
        entity.page = Int32(page)
        entity.url = url
        return entity
    }
}
