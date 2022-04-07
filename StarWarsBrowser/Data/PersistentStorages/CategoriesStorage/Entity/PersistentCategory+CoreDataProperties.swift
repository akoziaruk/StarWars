//
//  PersistentCategory+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 06.04.2022.
//
//

import Foundation
import CoreData


extension PersistentCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentCategory> {
        return NSFetchRequest<PersistentCategory>(entityName: "PersistentCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: URL?
    @NSManaged public var details: NSSet?

}

// MARK: Generated accessors for details
extension PersistentCategory {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: PersistentDetail)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: PersistentDetail)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}

extension PersistentCategory : Identifiable {

}
