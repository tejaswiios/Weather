//
//  ImageCacheManager.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import Foundation
import SwiftUI

import Foundation
import UIKit

/// A singleton class responsible for managing an in-memory cache for images.
/// This class uses `NSCache` to store images in memory, allowing for efficient
/// retrieval and reducing the need for repeated network requests.
class ImageCacheManager {
    
    /// The shared instance of `ImageCacheManager`.
    /// This singleton pattern allows for a single, globally accessible instance
    /// of the cache manager.
    static let shared = ImageCacheManager()
    
    /// The underlying cache storage.
    /// This uses `NSCache` to hold images associated with their corresponding keys.
    private var cache = NSCache<NSString, UIImage>()
    
    /// Caches an image for a given key.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to be cached.
    ///   - key: The key associated with the image, used for retrieval.
    func cacheImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    /// Retrieves a cached image for a given key.
    ///
    /// - Parameter key: The key associated with the desired image.
    /// - Returns: The cached `UIImage` if found, or `nil` if not found.
    func image(for key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
}
