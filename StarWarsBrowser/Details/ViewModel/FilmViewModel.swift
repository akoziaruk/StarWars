//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

struct FilmViewModel: DetailViewModelType {
    let uuid = UUID()
    var title: String!
    var director: String!
    var openingCrawl: String!
    
    init(model: Film) {
        self.title = model.title
        self.director = model.director
        self.openingCrawl = model.openingCrawl
    }
}

extension FilmViewModel: Hashable {
    static func == (lhs: FilmViewModel, rhs: FilmViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
