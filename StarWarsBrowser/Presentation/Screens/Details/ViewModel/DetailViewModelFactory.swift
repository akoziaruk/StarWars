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
    public static func viewModel(from detail: Detailable,
                                      imageLoader: (Detailable) -> AnyPublisher<UIImage?, Never>) -> AnyHashable {
        if let film = detail as? Film {
            return FilmViewModel(title: film.name,
                                 director: film.director,
                                 openingCrawl: film.openingCrawl,
                                 image: imageLoader(film as! Detailable))
        } else {
            return DetailViewModel(name: detail.name,
                                   image: imageLoader(detail))
        }
        
    }
}
