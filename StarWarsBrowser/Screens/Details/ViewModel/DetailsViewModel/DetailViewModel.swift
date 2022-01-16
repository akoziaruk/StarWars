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
    let uuid = UUID()
    let name: String!
    let image: AnyPublisher<UIImage?, Never>

    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name
        self.image = image
    }
}

extension DetailViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

