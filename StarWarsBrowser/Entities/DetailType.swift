//
//  DetailType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

protocol DetailType: Decodable { }

enum DetailDataType {
    case film
    case unknown
}

extension String {
    var dataType: DetailDataType? {
        if self.contains("films") {
            return .film
        }
        return nil
    }
}
