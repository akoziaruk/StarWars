//
//  PersistentDetail+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 03.04.2022.
//
//

import Foundation
import CoreData


extension PersistentDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentDetail> {
        return NSFetchRequest<PersistentDetail>(entityName: "PersistentDetail")
    }

    @NSManaged public var name: String!
    @NSManaged public var director: String?
    @NSManaged public var openingCrawl: String?

}

extension PersistentDetail : Identifiable {

}
