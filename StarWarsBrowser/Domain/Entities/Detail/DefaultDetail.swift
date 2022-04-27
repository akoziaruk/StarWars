//
//  DefaultDetail.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/20/21.
//

import Foundation

struct DefaultDetail: Detailable {
    var name: String
}

extension DefaultDetail: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}
