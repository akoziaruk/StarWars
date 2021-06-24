//
//  FilmViewModel.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 23.06.2021.
//

import Foundation

class FilmViewModel: DetailsViewModel {
    let title: String!
    let director: String!
    let openingCrawl: String!
    init(_ film: Film) {
        title = film.title
        director = film.director
        openingCrawl = film.openingCrawl
    }
}


