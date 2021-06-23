//
//  DetailTypeProtocol.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

protocol DetailType: Decodable {
    
}

enum DataType {
    case film
    case unknown
}

extension String {
    
    var dataType: DataType {
        if self.contains("films") {
            return .film
        }
        return .unknown
    }
    
}
