//
//  Category+CoreDataClass.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//
//

import Foundation
import CoreData

public class Category: NSManagedObject {

    convenience init(name: String, url: URL, decoder: Decoder) {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        self.name = name
        self.url = url
    }
    
}
