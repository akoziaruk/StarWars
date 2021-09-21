//
//  PeopleViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import Foundation

struct PeopleViewModel: DetailViewModelType {
    let uuid = UUID()
    let name: String
    
    init(model: People) {
        self.name = model.name
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
