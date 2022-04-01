//
//  PersistanceDecoder.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import CoreData

class PersistanceDecoder: JSONDecoder {
    init(managedObjectContext: NSManagedObjectContext) {
        super.init()
        
        userInfo[CodingUserInfoKey.context!] = managedObjectContext
    }
}
