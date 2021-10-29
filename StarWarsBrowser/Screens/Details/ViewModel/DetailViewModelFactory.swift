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
    public static func viewModel(from detail: Detail, imageLoader: (Detail) -> AnyPublisher<UIImage?, Never>) -> DetailViewModel {
        switch detail {
        case let film as Film:
            return FilmViewModel(title: film.title, director: film.director, openingCrawl: film.openingCrawl, image: imageLoader(film))
        case let person as People:
            return PeopleViewModel(name: person.name, image: imageLoader(person))
//        case let item as Planet:
//            return PlanetViewModel(model: item)
        default:
            fatalError("Unknown item for ViewModel")
        }
    }
}
