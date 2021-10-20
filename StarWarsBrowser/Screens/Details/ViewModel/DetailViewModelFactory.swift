//
//  DetailViewModelFactory.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

class DetailViewModelFactory {
    public static func viewModels(for items: [Detail]) -> [DetailViewModelType] {
       return items.compactMap {
        switch $0 {
        case let item as Film:
            return FilmViewModel(model: item)
        case let item as People:
            return PeopleViewModel(model: item)
//        case let item as Planet:
//            return PlanetViewModel(model: item)
        default:
            fatalError("Unknown item for ViewModel")
        }
       }
    }
}
