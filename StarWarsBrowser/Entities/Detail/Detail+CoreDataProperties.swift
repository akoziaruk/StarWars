//
//  Detail+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var director: String?
    @NSManaged public var name: String?
    @NSManaged public var openingCrawl: String?

}

extension Detail : Identifiable {

}
