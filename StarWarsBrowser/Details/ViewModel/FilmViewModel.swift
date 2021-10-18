//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import UIKit

struct FilmViewModel: DetailViewModelType {
    let uuid = UUID()
    var title: String!
    var director: String!
    var openingCrawl: String!
    var image: UIImage?
    
    init(model: Film) {
        self.title = model.title
        self.director = model.director
        self.openingCrawl = model.openingCrawl.removeNewLineSymbols()
        self.image = model.image
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
