//
//  PeopleViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import Foundation
import UIKit

struct PeopleViewModel: DetailViewModelType {
    let uuid = UUID()
    let name: String
    let height: String
    let hairColor: String
    let eyeColor: String
    let birthYear: String
    let image: UIImage?
    
    init(model: People) {
        self.name = model.name
        self.height = model.height + "cm"
        self.hairColor = model.hairColor
        self.eyeColor = model.eyeColor
        self.birthYear = model.birthYear
        self.image = model.image
    }
}

extension PeopleViewModel: Hashable {
    static func == (lhs: PeopleViewModel, rhs: PeopleViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
