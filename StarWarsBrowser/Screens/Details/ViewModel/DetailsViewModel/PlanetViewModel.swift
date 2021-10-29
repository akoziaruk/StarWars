//
//  PlanetViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/20/21.
//

import Foundation
import UIKit.UIImage
import Combine

class PlanetViewModel {
    let uuid = UUID()
    let name: String!
    
    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name

//        super.init(image: image)
    }
}

extension PlanetViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    static func == (lhs: PlanetViewModel, rhs: PlanetViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

