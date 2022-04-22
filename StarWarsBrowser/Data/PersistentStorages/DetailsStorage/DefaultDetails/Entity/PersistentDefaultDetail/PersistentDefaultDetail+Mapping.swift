//
//  PersistentDetail+Mapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 07.04.2022.
//

import Foundation
import CoreData

extension NSOrderedSet {
    func toDTO() -> DefaultDetailsDTO {
        return DefaultDetailsDTO(details: self)
    }
}

extension DefaultDetailsDTO {
    init(details: NSOrderedSet) {
        results = details.map { DefaultDetailsDTO.DetailDTO(detail: $0 as! PersistentDefaultDetail) }
    }
}

extension DefaultDetailsDTO.DetailDTO {
    init(detail: PersistentDefaultDetail) {
        name = detail.name
    }
    
    func toEntity(in context: NSManagedObjectContext) -> PersistentDefaultDetail {
        let detail = PersistentDefaultDetail(context: context)
        detail.name = name
        return detail
    }
}
