//
//  FirebaseFolder.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation

struct StorageFolder {
    static func path(for category: Category.T) -> String? {
        switch category {
            case .films:        return "films"
            case .people:       return "people"
            case .planets:      return "planets"
            case .species:      return "spiecies"
            case .starships:    return "starships"
            case .vehicles:     return "vehicles"
            case .unknown:      return nil
        }
    }
}
