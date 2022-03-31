//
//  Detail+Path.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/30/21.
//

import Foundation

extension Detailable {
    var bucketImagePath: String {
        return APIConstants.firebaseBucketPath + imagePath.storageFormatted + ".jpg"
    }
}

/** Preparing Firebase Bucket filename.
    Converting to snake case.
    For some failed to return correct file names:
    - "é" in "Padmé Amidala"
    - "/" in "TIE/LN starfighter"
 
    Note: Can be optimized with changing multiple usage of replacingOccurrences function
*/

fileprivate extension String {
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
