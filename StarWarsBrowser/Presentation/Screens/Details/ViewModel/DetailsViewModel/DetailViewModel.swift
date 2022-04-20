//
//  DetailViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import Foundation
import UIKit.UIImage
import Combine

struct DetailViewModel {
    let name: String!
    let image: AnyPublisher<UIImage?, Never>

    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name
        self.image = image
    }
}

extension DetailViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
        lhs.name == rhs.name
    }
}

