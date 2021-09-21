//
//  DetailType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

protocol Detail: Decodable {
    var type: ItemType { get }
}

enum DetailCodingKeys: String, CodingKey, CaseIterable {
    case results = "results"
}
