//
//  PeopleViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import Foundation
import UIKit.UIImage
import Combine

struct PeopleViewModel {
    let uuid = UUID()
    let name: String!
    
    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name
    }
}

extension PeopleViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    static func == (lhs: PeopleViewModel, rhs: PeopleViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

