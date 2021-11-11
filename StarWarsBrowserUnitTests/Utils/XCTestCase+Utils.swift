//
//  XCTestCase+Utils.swift
//  StarWarsBrowserUnitTests
//
//  Created by Olexander Koziaruk on 11/10/21.
//
import XCTest
import Foundation
@testable import StarWarsBrowser

extension Decodable {
    static func loadFromFile(_ filename: String, target: AnyClass) -> Self {
        do {
            let bundle = Bundle(for: target)
            let path = bundle.path(forResource: filename, ofType: nil)!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
