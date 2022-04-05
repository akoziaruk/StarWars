//
//  ImageService.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/29/21.
//

import Foundation
import Combine
import Firebase
import FirebaseStorageCombineSwift
import UIKit.UIImage

final class ImageLoaderService: ImageLoaderServiceType {
    private let cache: ImageCacheType = ImageCache()

    func loadImage(for path: String) -> AnyPublisher<UIImage?, Never> {
        if let image = cache.image(for: path) {
            return .just(image)
        }
        return Storage.storage().reference(forURL: path)
            .getData(maxSize: Constants.maxSize)
            .map { (data) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache.insertImage(image, for: path)
            })
            .eraseToAnyPublisher()
    }
    
    struct Constants {
        static let maxSize = 1 * 1024 * 1024 as Int64
    }
}
