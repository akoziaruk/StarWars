//
//  Detail+FirabaseStorage.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/30/21.
//

import Foundation

extension Detailable {
    func storagePath(for category: Category.T) -> String? {
        guard let folder = StorageFolder.path(for: category) else { return nil }
        
        return DataLoaderConstants.bucket + (folder + "/" + name).storageFormatted + DataLoaderConstants.imageExtension
    }
}
