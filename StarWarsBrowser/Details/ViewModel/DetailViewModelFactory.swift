//
//  DetailViewModelFactory.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

class DetailViewModelFactory {
    public static func viewModels(for items: [DetailType]) -> [DetailViewModelType] {
       return items.compactMap {
        switch $0 {
        case let item as Film:
            return FilmViewModelType(model: item)
        default:
            return nil
        }
       }
    }
}
