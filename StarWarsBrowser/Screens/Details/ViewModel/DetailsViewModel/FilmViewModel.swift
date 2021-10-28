//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import UIKit

class FilmViewModel: DetailViewModel {
    var title: String!
    var director: String!
    var openingCrawl: String!
    var image: UIImage?
    
    init(model: Film) {
        super.init()
        self.title = model.title
        self.director = model.director
        self.openingCrawl = model.openingCrawl.removeNewLineSymbols()
        self.image = model.image
    }
}
