//
//  DetailTypeProtocol.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.06.2021.
//

import Foundation

protocol DetailsType: Decodable {
    var items: [DetailType] { get }
}
