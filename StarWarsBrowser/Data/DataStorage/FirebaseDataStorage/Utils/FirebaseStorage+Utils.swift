//
//  FirebaseStorage+Utils.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation

/** Preparing Firebase Bucket filename.
    Converting to snake case.
    For some failed to return correct file names:
    - "é" in "Padmé Amidala"
    - "/" in "TIE/LN starfighter"
 
    Note: Can be optimized with changing multiple usage of replacingOccurrences function
*/

extension String {
    var storageFormatted: String {
        let name = filename
                    .snakeCase
                    .replacingOccurrences(of: "é", with: "e")
                    .replacingOccurrences(of: "/", with: ":")
                        
        return String(prefix(count - name.count) + name)
    }
    
    var filename: String {
        let range = range(of: "/")!
        return String(self[range.upperBound...])
    }
}
