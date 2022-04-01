//
//  Category+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String!
    @NSManaged public var url: URL!
    @NSManaged public var details: Detail?

}

extension Category : Identifiable {

}
