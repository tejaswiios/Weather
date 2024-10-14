//
//  WeatheSearchContentView.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import SwiftUI

/// A SwiftUI view for searching weather forecasts based on city names or the user's current location.
struct WeatheSearchContentView: View {
    
    @StateObject private var weatherLocationModel = WeatherLocationViewModel() // ViewModel for managing location
    @StateObject private var viewModel = WeatherViewModel() // ViewModel for managing weather data
    @State private var cityName: String = "" // State variable to hold the city name input
    @State private var showText = true // State variable for displaying text conditionally
    @FocusState private var isTextFieldFocused: Bool // State for focus
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 20) {
                    if weatherLocationModel.location != nil { // Check if location is available
                        // Text field for city name input
                        TextField("Enter city name", text: $cityName)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 5, y: 5)
                            .focused($isTextFieldFocused) // Bind the focus state to the TextField
                            .padding(.top, 20)
                            .onTapGesture {
                                // Automatically focus on the TextField when tapped
                                isTextFieldFocused = true
                            }
                        // Search button
                        Button(action: {
                            viewModel.fetchCityCordinates(for: cityName) // Fetch coordinates for the entered city
                            // Dismiss the keyboard
                            isTextFieldFocused = false
                        }) {
                            Text("Search for Weather Forecast")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        
                        Spacer()
                        if let weather = viewModel.weatherData { // If weather data is available
                            VStack(spacing: 16) {
                                // Display weather information
                                Text(weather.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Text("\(String(format:"%.2f", weather.main.temp - 273.15))°C")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                
                                // Weather icon
                                if let icon = weather.weather.first?.icon {
                                    let iconURL = "\(cacheImageURL)\(icon)\(extensionImage)"
                                    AsyncImageView(imageURL: iconURL)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                }
                                
                                // Min/Max Temperature View
                                WeatherStringCustomView(titleString: "Min Temp", subtitleString: "\(String(format: "%.2f", weather.main.tempMin - 273.15))°C", secondTitleString: "Max Temp", secondSubtitleString: "\(String(format: "%.2f", weather.main.tempMax - 273.15))°C")
                                
                                Spacer()
                                // Feels Like and Weather Description View
                                WeatherStringCustomView(titleString: "Feels Like", subtitleString: "\(String(format: "%.2f", weather.main.feelsLike - 273.15))°C", secondTitleString: "Weather", secondSubtitleString: "\(weather.weather.first?.description ?? "")")
                                Spacer()
                                // Humidity and Wind Speed View
                                WeatherStringCustomView(titleString: "Humidity", subtitleString: "\(weather.main.humidity)", secondTitleString: "Wind Speed", secondSubtitleString: "\(String(format: "%.2f", weather.wind.speed)) m/s")
                            }
                            .padding()
                        } else if let error = viewModel.errorMessage { // If there's an error
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }
                    } else {
                        // Request permission button
                        Button {
                            weatherLocationModel.requestPremission() // Request location permission
                        } label: {
                            if weatherLocationModel.authorizationStatus == .notDetermined {
                                Text("Please Click here to access the location permission settings for weather forecast")
                                    .foregroundColor(.white)
                                    .opacity(self.showText ? 1 : 0)
                            }
                        }
                        .onAppear {
                            weatherLocationModel.fetchLocation() // Fetch location on appear
                        }
                        .onDisappear {
                            if weatherLocationModel.authorizationStatus == .authorizedWhenInUse {
                                // Handle authorized state
                            }
                        }
                    }
                }
                .alert(isPresented: .constant(weatherLocationModel.authorizationStatus == .denied)) {
                    Alert(title: Text("Location Denied"), message: Text("Location access denied. Please enable it in settings."), primaryButton: .default(Text("OK"), action: {
                        openAppSettings() // Open app settings
                    }), secondaryButton: .cancel(Text("Cancel")))
                }
                .onAppear {
                    // Automatically focus on the TextField when the view appears
                    isTextFieldFocused = true
                    
                    // Fetch weather data for the last saved city or default city
                    if viewModel.weatherData == nil {
                        if let location = weatherLocationModel.location {
                            viewModel.fetchWeatherData(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
                        }
                    }
                }
                .padding(12)
                .onTapGesture {
                    // Dismiss the keyboard when tapping outside the TextField
                    isTextFieldFocused = false
                }
            }
        }
    }
}

/// Opens the app settings to allow the user to change location permissions.
func openAppSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
    }
}

#Preview {
    WeatheSearchContentView()
}
