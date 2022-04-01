//
//  PersistanceDataService.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import CoreData

final class PersistanceDataService: PersistanceDataServiceType {
    
    var viewContext: NSManagedObjectContext {
        return PersistanceController.shared.container.viewContext
    }
}
