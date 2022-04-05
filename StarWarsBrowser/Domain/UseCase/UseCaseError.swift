//
//  UseCaseError.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/20/21.
//

import Foundation

enum UseCaseError: LocalizedError {
    case unknownType
    
    var description: String? {
        switch self {
        case .unknownType:            return "Unknown type"
        }
    }
}
