//
//  PersistentDefaultDetail+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//
//

import Foundation
import CoreData


extension PersistentDefaultDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentDefaultDetail> {
        return NSFetchRequest<PersistentDefaultDetail>(entityName: "PersistentDefaultDetail")
    }

    @NSManaged public var name: String!
    @NSManaged public var page: Int32
    @NSManaged public var type: Int16

}

extension PersistentDefaultDetail : Identifiable {

}
