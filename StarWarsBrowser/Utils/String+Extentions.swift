//
//  String+Extentions.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/18/21.
//

import Foundation

extension String {
    
    func removeNewLineSymbols() -> String {
        return replacingOccurrences(of: "\r\n", with: "")
    }
    
}
