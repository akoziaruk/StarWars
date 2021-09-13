//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

struct FilmViewModelType: DetailViewModelType {
    var title: String!
    var director: String!
    var openingCrawl: String!
    
    init(model: Film) {
        self.title = model.title
        self.director = model.director
        self.openingCrawl = model.openingCrawl
    }
}

extension FilmViewModelType: Equatable {
    static func == (lhs: FilmViewModelType, rhs: FilmViewModelType) -> Bool {
        return lhs.title > rhs.title
    }
}
