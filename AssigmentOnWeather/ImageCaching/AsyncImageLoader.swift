//
//  AsyncImageLoader.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import Foundation
import SwiftUI

/// A class responsible for loading images asynchronously from a specified URL.
/// It conforms to the `ObservableObject` protocol to allow SwiftUI views to respond
/// to changes in its `@Published` properties, specifically the loaded image.
class AsyncImageLoader: ObservableObject {
    
    /// The loaded image. This property is marked with `@Published` to notify
    /// any views observing it when its value changes.
    @Published var image: UIImage?
    
    /// Loads an image from the specified URL string.
    /// If the image is already cached, it retrieves the cached image and updates
    /// the `image` property. If not, it fetches the image from the network.
    ///
    /// - Parameter urlString: The URL string from which to load the image.
    func loadImage(from urlString: String) {
        // Check if the image is already cached.
        if let cachedImage = ImageCacheManager.shared.image(for: urlString) {
            self.image = cachedImage
            return
        }
        
        // Ensure the URL is valid.
        guard let url = URL(string: urlString) else { return }
        
        // Create a data task to fetch the image from the URL.
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            // Ensure there is data and no error.
            guard let data = data, error == nil else { return }
            
            // Switch to the main thread to update the UI.
            DispatchQueue.main.async {
                // Create a UIImage from the fetched data.
                if let image = UIImage(data: data) {
                    // Cache the image for future use.
                    ImageCacheManager.shared.cacheImage(image, for: urlString)
                    // Update the `image` property to trigger UI updates.
                    self.image = image
                }
            }
        }
        // Start the data task.
        task.resume()
    }
}
