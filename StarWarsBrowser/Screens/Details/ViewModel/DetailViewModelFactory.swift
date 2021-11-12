//
//  DetailViewModelFactory.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import UIKit.UIImage
import Combine

class DetailViewModelFactory {

    public static func viewModel(from detail: Detailable, imageLoader: (Detailable) -> AnyPublisher<UIImage?, Never>) -> AnyHashable {
        switch detail {
        case let film as Film:
            return FilmViewModel(title: film.title,
                                 director: film.director,
                                 openingCrawl: film.openingCrawl,
                                 image: imageLoader(film))
        case let character as Сharacter:
            return PeopleViewModel(name: character.name,
                                   image: imageLoader(character))
        case let planet as Planet:
            return PeopleViewModel(name: planet.name,
                                   image: imageLoader(planet))
        default:
            fatalError("Unknown item for ViewModel")
        }
    }
}
