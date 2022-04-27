//
//  Decodable+LoadFromFile.swift
//  StarWarsBrowserUnitTests
//
//  Created by Alexander Koziaruk on 27.04.2022.
//

import XCTest
import Foundation
@testable import StarWarsBrowser

extension Decodable {
    static func loadFromFile(_ filename: String, target: AnyClass, decoder: JSONDecoder = JSONDecoder()) -> Self {
        do {
            let bundle = Bundle(for: target)
            let path = bundle.path(forResource: filename, ofType: nil)!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try decoder.decode(Self.self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
