//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import UIKit.UIImage
import Combine

class FilmViewModel: DetailViewModel {
    let title: String!
    let director: String!
    let openingCrawl: String!
    
    init(title: String, director: String, openingCrawl: String, image: AnyPublisher<UIImage?, Never>) {
        self.title = title
        self.director = director
        self.openingCrawl = openingCrawl.removeNewLineSymbols()
        
        super.init(image: image)
    }
}
