//
//  PersistanceController.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 01.04.2022.
//

import Foundation
import CoreData

class PersistanceController {
    
    static let shared = PersistanceController()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
}

