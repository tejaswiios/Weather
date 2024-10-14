//
//  SwiftUIView.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import SwiftUI

/// A SwiftUI view that asynchronously loads and displays an image from a given URL.
/// It utilizes the `AsyncImageLoader` class to handle the image loading process,
/// showing a progress view while the image is being fetched.
struct AsyncImageView: View {
    /// An observable object that manages the image loading process.
    @StateObject private var imageLoader = AsyncImageLoader()
    
    /// The URL string of the image to be loaded.
    let imageURL: String
    
    var body: some View {
        Group {
            // Check if the image has been loaded successfully
            if let image = imageLoader.image {
                // Display the loaded image
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit) // Maintain aspect ratio while fitting in available space
            } else {
                // Show a progress view while the image is loading
                ProgressView("Loading Image...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue)) // Circular progress style with blue tint
                    .scaleEffect(1.5) // Adjust the size of the progress view
            }
        }
        .onAppear {
            // Trigger the image loading process when the view appears
            imageLoader.loadImage(from: imageURL)
        }
    }
}

#Preview {
    AsyncImageView(imageURL: "\(cacheImageURL)10n\(extensionImage)") // Example image URL
        .frame(width: 100, height: 100) // Set frame for the image view
        .padding() // Add padding around the image view
}
