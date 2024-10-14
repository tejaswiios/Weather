//
//  WeatherModel.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import Foundation

// MARK: - WeatherResponse
/// The main structure representing the response from a weather API. It contains
/// all the necessary information about the weather conditions, including location,
/// weather details, temperature, wind, clouds, and system data.
///
/// This structure conforms to the `Codable` protocol, allowing it to be easily
/// encoded/decoded from/to JSON format when interacting with APIs.
struct WeatherResponse: Codable {
    
    // The geographic coordinates of the location (latitude and longitude).
    let coord: CoordinatesCity
    
    // An array of weather conditions, which includes main status, description, and icon.
    let weather: [Weather]
    
    // Internal base station information.
    let base: String
    
    // Temperature and other atmospheric conditions.
    let main: Main
    
    // Visibility distance in meters.
    let visibility: Int
    
    // Wind speed and direction.
    let wind: Wind
    
    // Cloudiness percentage.
    let clouds: Clouds
    
    // Time of data calculation (UNIX timestamp).
    let dt: Int
    
    // System data like country, sunrise, and sunset times.
    let sys: Sys
    
    // The shift in seconds from UTC.
    let timezone: Int
    
    // City ID.
    let id: Int
    
    // Name of the city.
    let name: String
    
    // Status code of the API response.
    let cod: Int
}

// MARK: - Weather
/// Represents the weather conditions for the specified location. This includes
/// the weather ID, main description (e.g., "Clear"), detailed description (e.g., "clear sky"),
/// and an icon representing the weather.
struct Weather: Codable {
    
    // The weather condition ID.
    let id: Int
    
    // The main weather status (e.g., "Clear").
    let main: String
    
    // A more detailed weather description (e.g., "clear sky").
    let description: String
    
    // The icon string, which can be used to fetch the weather icon.
    let icon: String
    
    // Computed property to generate the full URL for the weather icon image.
    var iconURL: String {
        return "\(cacheImageURL)\(icon)\(extensionImage)"
    }
}

// MARK: - Main
/// Represents the primary atmospheric conditions such as temperature, pressure, and humidity.
/// Includes min/max temperatures, "feels like" temperature, and optional sea and ground level pressures.
struct Main: Codable {
    
    // Current temperature in Kelvin.
    let temp: Double
    
    // "Feels like" temperature in Kelvin.
    let feelsLike: Double
    
    // Minimum observed temperature in Kelvin.
    let tempMin: Double
    
    // Maximum observed temperature in Kelvin.
    let tempMax: Double
    
    // Atmospheric pressure at sea level, if available.
    let pressure: Int
    
    // Humidity percentage.
    let humidity: Int
    
    // Atmospheric pressure at sea level (optional).
    let seaLevel: Int?
    
    // Atmospheric pressure at ground level (optional).
    let grndLevel: Int?
    
    // MARK: - CodingKeys
    /// Custom keys for mapping JSON properties to Swift properties.
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Wind
/// Represents wind conditions including speed (in meters per second) and direction (in degrees).
struct Wind: Codable {
    
    // Wind speed in meters per second.
    let speed: Double
    
    // Wind direction in degrees (meteorological).
    let deg: Int
}

// MARK: - Clouds
/// Represents the cloudiness percentage.
struct Clouds: Codable {
    
    // Cloudiness percentage (0-100).
    let all: Int
}

// MARK: - Sys
/// Contains system-related information such as the country code, sunrise, and sunset times.
struct Sys: Codable {
    
    // System type, generally used internally by the API.
    let type: Int?
    
    // System ID.
    let id: Int
    
    // Country code (e.g., "US" for the United States).
    let country: String
    
    // Sunrise time (UNIX timestamp).
    let sunrise: Int
    
    // Sunset time (UNIX timestamp).
    let sunset: Int
}
