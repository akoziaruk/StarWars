//
//  PersistentFilmDetail+CoreDataProperties.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.04.2022.
//
//

import Foundation
import CoreData


extension PersistentFilmDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistentFilmDetail> {
        return NSFetchRequest<PersistentFilmDetail>(entityName: "PersistentFilmDetail")
    }

    @NSManaged public var director: String!
    @NSManaged public var name: String!
    @NSManaged public var openingCrawl: String!
    @NSManaged public var releaseDate: Date!
    @NSManaged public var page: Int32

}

extension PersistentFilmDetail : Identifiable {

}
