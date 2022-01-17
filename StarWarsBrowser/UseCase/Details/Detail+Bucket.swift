//
//  Detail+Path.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/30/21.
//

import Foundation

extension Detailable {
    var bucketImagePath: String {
        return APIConstants.firebaseBucketPath + imagePath.normalised + ".jpg"
    }
}

/** Firebase Bucket failed to return file name with "é" symbol (Padmé Amidala) */
fileprivate extension String {
    var normalised: String {
        return replacingOccurrences(of: "é", with: "e")
    }
}
