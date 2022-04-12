//
//  PersistentDefaultDetailRequest+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//
//

import Foundation
import CoreData


extension PersistentDefaultDetailRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentDefaultDetailRequest> {
        return NSFetchRequest<PersistentDefaultDetailRequest>(entityName: "PersistentDefaultDetailRequest")
    }

    @NSManaged public var page: Int32
    @NSManaged public var url: URL
    @NSManaged public var details: Set<PersistentDefaultDetail>

}

// MARK: Generated accessors for details
extension PersistentDefaultDetailRequest {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: PersistentDefaultDetail)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: PersistentDefaultDetail)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}

extension PersistentDefaultDetailRequest : Identifiable {

}
