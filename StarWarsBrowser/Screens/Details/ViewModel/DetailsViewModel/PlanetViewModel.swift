//
//  PlanetViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/20/21.
//

import Foundation
import UIKit.UIImage
import Combine

class PlanetViewModel: DetailViewModel {
    let name: String!
    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name

        super.init(image: image)
    }
}
