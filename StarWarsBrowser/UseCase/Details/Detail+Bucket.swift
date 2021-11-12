//
//  Detail+Path.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/30/21.
//

import Foundation

extension Detailable {
    var bucketImagePath: String {
        return APIConstants.firebaseBucketPath + imagePath + ".jpg"
    }
}
