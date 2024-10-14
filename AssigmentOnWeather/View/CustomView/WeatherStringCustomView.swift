//
//  WeatherStringCustomView.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/13/24.
//

import SwiftUI

/// A SwiftUI view that displays two customizable sections with titles and subtitles.
/// Each section features a gradient background, rounded corners, and shadow effects.
struct WeatherStringCustomView: View {
    /// The main title for the first section.
    var titleString: String = ""
    
    /// The subtitle for the first section.
    var subtitleString: String = ""
    
    /// The main title for the second section.
    var secondTitleString: String = ""
    
    /// The subtitle for the second section.
    var secondSubtitleString: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                // First section
                VStack {
                    Text(titleString)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer(minLength: 2)
                    Text(subtitleString)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 200, minHeight: 150) // Fixed width and height
                .padding(15)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(15) // Rounded corners
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5) // Shadow effect
                
                // Second section
                VStack {
                    Text(secondTitleString)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Spacer(minLength: 2)
                    Text(secondSubtitleString)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: 200, minHeight: 150) // Fixed width and height
                .padding(15)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(15) // Rounded corners
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5) // Shadow effect
            }
            .padding(20) // Padding around HStack
        }
        .background(Color(.clear).ignoresSafeArea()) // Clear background
    }
}

#Preview {
    // Preview the WeatherStringCustomView with example data
    WeatherStringCustomView(titleString: "Hello, World!", subtitleString: "Welcome to SwiftUI")
}
