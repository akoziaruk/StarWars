//
//  PersistentCategory+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//
//

import Foundation
import CoreData


extension PersistentCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentCategory> {
        return NSFetchRequest<PersistentCategory>(entityName: "PersistentCategory")
    }

    @NSManaged public var name: String!
    @NSManaged public var url: URL!

}

extension PersistentCategory : Identifiable {

}
