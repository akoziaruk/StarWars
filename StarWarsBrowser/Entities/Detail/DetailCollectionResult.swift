//
//  DetailCollectionResult.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/20/21.
//

import Foundation

struct DetailCollectionResult {
    var items: [Detail]
    var count: Int
}

extension DetailCollection {
    var result: DetailCollectionResult {
       return DetailCollectionResult(items: items,
                                     count: count)
    }
}
