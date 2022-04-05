//
//  ImageCache.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/29/21.
//

import UIKit
import ImageIO

// In-memory image cache
protocol ImageCacheType: AnyObject {
    func image(for path: String) -> UIImage?
    func insertImage(_ image: UIImage?, for path: String)
    func removeImage(for path: String)
    func removeAllImages()
    subscript(_ path: String) -> UIImage? { get set }
}

final class ImageCache: ImageCacheType {

    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    private let lock = NSLock()
    private let config: Config

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
    }

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    func image(for path: String) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image in memory
        if let decodedImage = decodedImageCache.object(forKey: path as AnyObject) as? UIImage {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: path as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: path as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }

    func insertImage(_ image: UIImage?, for path: String) {
        guard let image = image else { return removeImage(for: path) }
        let decompressedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decompressedImage, forKey: path as AnyObject, cost: 1)
        decodedImageCache.setObject(image as AnyObject, forKey: path as AnyObject, cost: decompressedImage.diskSize)
    }

    func removeImage(for path: String) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: path as AnyObject)
        decodedImageCache.removeObject(forKey: path as AnyObject)
    }

    func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

    subscript(_ key: String) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

fileprivate extension UIImage {

    func decodedImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        self.draw(at: CGPoint.zero)
        UIGraphicsEndImageContext()
        return self
    }

    // Rough estimation of how much memory image uses in bytes
    var diskSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    }
}

