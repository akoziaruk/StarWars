//
//  DetailImagesRepository.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import Combine
import UIKit.UIImage

class DetailImagesRepository: DetailImagesRepositoryType {
    private let storage: DataStorageType
    private let cache: ImageCacheType

    init(cache: ImageCacheType, storage: DataStorageType) {
        self.cache = cache
        self.storage = storage
    }
    
    func loadImage(for detail: Detailable, category: Category.T) -> AnyPublisher<UIImage?, Never> {
        guard let path = detail.storagePath(for: category) else { return .just(nil) }
        
        if let image = cache.image(for: path) {
            return .just(image)
        }
        
        return storage.loadData(for: path)
            .map { (data) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[weak self] image in
                guard let image = image else { return }
                self?.cache.insertImage(image, for: path)
            })
            .eraseToAnyPublisher()
    }
    
    struct Constants {
        static let maxSize = 1 * 1024 * 1024 as Int64
    }
}
