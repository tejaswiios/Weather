//
//  WeatherSplashScreen.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/11/24.
//

import SwiftUI

/// A SwiftUI view that displays a splash screen before transitioning to the main content.
struct WeatherSplashScreen: View {
    @State private var isActive = false // State variable to control active content
    @State private var opacity = 0.0 // State variable to control opacity for fade-in effect
    
    var body: some View {
        if isActive {
            // Main content goes here
            WeatheSearchContentView() // Transition to the main content after splash
        } else {
            VStack {
                Image(systemName: "smoke.circle.fill") // Placeholder for app logo
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                Text("Weather")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
            }
            .opacity(opacity) // Apply opacity to the splash screen
            .onAppear {
                // Fade-in animation
                withAnimation(.easeIn(duration: 2.0)) {
                    opacity = 1.0
                }
                // Delay before transitioning to the main content
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true // Set to true to show main content
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherSplashScreen() // Preview for the splash screen
}
