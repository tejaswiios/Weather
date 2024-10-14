//
//  WeatherCityModel.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/11/24.
//

import Foundation

// MARK: - WeatherCityModel
/// A model representing weather-related city information, including its name, localized names,
/// coordinates (latitude and longitude), country, and optionally state.
///
/// This struct conforms to the `Identifiable` and `Codable` protocols, making it suitable for
/// SwiftUI lists and encoding/decoding JSON data.
///
/// The struct includes a custom initializer to handle JSON decoding and proper mapping
/// of latitude and longitude to the `CoordinatesCity` structure.
struct WeatherCityModel: Identifiable, Codable {
    
    // Unique identifier for the model, automatically generated using UUID.
    var id: String = UUID().uuidString
    
    // Name of the city.
    let name: String
    
    // Optional local names of the city in different languages.
    let local_names: LocalNamesCity?
    
    // Geographic coordinates (latitude and longitude) of the city.
    let coordinates: CoordinatesCity
    
    // Country where the city is located.
    let country: String
    
    // Optional state or province where the city is located.
    let state: String?
    
    // MARK: - CodingKeys
    /// Coding keys to map JSON keys to struct properties.
    /// This is used for decoding and encoding JSON data, especially for handling custom keys.
    enum CodingKeys: String, CodingKey {
        case name
        case local_names = "local_names"
        case coordinates
        case country
        case lat
        case lon
        case state
    }
    
    // MARK: - Initializer (Decoding)
    /// Custom initializer to decode JSON into a `WeatherCityModel` object.
    /// It extracts the city name, local names, country, state, and coordinates (latitude and longitude).
    ///
    /// - Parameter decoder: The decoder object used to decode the JSON.
    /// - Throws: Decoding errors if any key is missing or of the wrong type.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode city name, local names, country, and state (if present)
        self.name = try container.decode(String.self, forKey: .name)
        self.local_names = try container.decodeIfPresent(LocalNamesCity.self, forKey: .local_names)
        self.country = try container.decode(String.self, forKey: .country)
        self.state = try container.decodeIfPresent(String.self, forKey: .state)
        
        // Decode latitude and longitude, and initialize `CoordinatesCity`
        let lat = try container.decode(Double.self, forKey: .lat)
        let lon = try container.decode(Double.self, forKey: .lon)
        self.coordinates = CoordinatesCity(lat: lat, lon: lon)
    }
    
    // MARK: - Encoding
    /// Function to encode a `WeatherCityModel` object into JSON.
    ///
    /// - Parameter encoder: The encoder object used to encode the model to JSON.
    /// - Throws: Encoding errors if any property fails to encode.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode name, local names, country, and state (if present)
        try container.encode(name, forKey: .name)
        try container.encode(local_names, forKey: .local_names)
        try container.encode(country, forKey: .country)
        try container.encode(state, forKey: .state)
        
        // Encode latitude and longitude from `CoordinatesCity`
        try container.encode(coordinates.lat, forKey: .lat)
        try container.encode(coordinates.lon, forKey: .lon)
    }
}


