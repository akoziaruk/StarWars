//
//  DetailViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

class DetailViewModel: Hashable {
    var uuid = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}


