//
//  FilmViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import UIKit.UIImage
import Combine

struct FilmViewModel {
    let title: String!
    let director: String!
    let openingCrawl: String!
    let image: AnyPublisher<UIImage?, Never>

    init(title: String, director: String, openingCrawl: String, image: AnyPublisher<UIImage?, Never>) {
        self.title = title
        self.director = director
        self.openingCrawl = openingCrawl.removeNewLineSymbols()
        self.image = image
    }
}

extension FilmViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
    static func == (lhs: FilmViewModel, rhs: FilmViewModel) -> Bool {
        lhs.title == rhs.title
    }
}
