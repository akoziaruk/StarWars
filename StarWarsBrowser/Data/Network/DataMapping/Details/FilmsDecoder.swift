//
//  FilmsDecoder.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.04.2022.
//

import Foundation

class FilmsDecoder: JSONDecoder {
    override init() {
        super.init()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
