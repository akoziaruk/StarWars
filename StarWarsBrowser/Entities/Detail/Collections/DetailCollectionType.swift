//
//  DetailCollection.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

protocol DetailCollection: Decodable {
    var items: [Detail] { get }
}

