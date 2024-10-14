//
//  WeatherViewModel.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import Combine
import Foundation

/// A ViewModel responsible for managing weather data and city location searches.
/// This class conforms to the `ObservableObject` protocol, allowing SwiftUI views to observe changes
/// in the weather data, error messages, and location results.
class WeatherViewModel: ObservableObject {
    
    /// An array of `WeatherCityModel` representing the cities found during a search.
    @Published var locations: [WeatherCityModel] = []
    
    /// An optional error message string that can be displayed when an error occurs.
    @Published var errorMessage: String?
    
    /// An optional `WeatherResponse` object that contains the fetched weather data.
    @Published var weatherData: WeatherResponse?
    
    /// An optional string representing the last searched city.
    @Published var lastSearchCity: String?
    
    /// A set of cancellables for managing Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes the ViewModel and fetches the last searched weather data.
    init() {
        fetchLastWeatherData() // Fetch the last search on initialization
    }
    
    /// Fetches city coordinates for a given city name.
    /// - Parameter city: The name of the city for which to fetch coordinates.
    func fetchCityCordinates(for city: String) {
        errorMessage = nil // Reset the error message
        let query = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        // Construct the URL for the geolocation API request
        guard let url = URL(string: "\(geoBaseUrl)\(query)\(baseURLAPIKey)\(weatherAPIKey)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        // Make the network request and handle the response
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [WeatherCityModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching city data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cities in
                self?.locations = cities // Update the locations array with the fetched cities
                if let firstCity = cities.first {
                    self?.fetchWeatherData(lat: firstCity.coordinates.lat, lon: firstCity.coordinates.lon) // Fetch weather data for the first city
                }
            })
            .store(in: &cancellables) // Store the cancellable to manage memory
    }
    
    /// Fetches weather data for a given latitude and longitude.
    /// - Parameters:
    ///   - lat: The latitude of the city.
    ///   - lon: The longitude of the city.
    func fetchWeatherData(lat: Double, lon: Double) {
        let urlString = "\(weatherBaserUrl)\(latURL)\(lat)\(lonURL)\(lon)\(baseURLAPIKey)\(weatherAPIKey)"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        // Make the network request for weather data
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.weatherData = weatherResponse // Update the weather data
                self?.saveLastWeatherData(weatherResponse) // Save the entire response for future use
            })
            .store(in: &cancellables) // Store the cancellable to manage memory
    }
    
    /// Saves the entire weather data to UserDefaults.
    /// - Parameter weather: The `WeatherResponse` object to save.
    func saveLastWeatherData(_ weather: WeatherResponse) {
        if let encoded = try? JSONEncoder().encode(weather) {
            UserDefaults.standard.set(encoded, forKey: "LastWeatherData") // Save encoded data to UserDefaults
        }
    }
    
    /// Fetches the last saved weather data from UserDefaults.
    func fetchLastWeatherData() {
        if let savedData = UserDefaults.standard.data(forKey: "LastWeatherData"),
           let decodedData = try? JSONDecoder().decode(WeatherResponse.self, from: savedData) {
            self.weatherData = decodedData // Update weather data with saved data
        }
    }
}
