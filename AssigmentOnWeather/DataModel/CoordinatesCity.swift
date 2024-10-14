//
//  CoordinatesCity.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/11/24.
//

import Foundation

// MARK: - CoordinatesCity
/// A model representing the geographical coordinates of a city.
/// This struct is used to store and encode/decode the latitude and longitude
/// values of a location, typically used for weather forecasting, mapping, or
/// other location-based services.
struct CoordinatesCity: Codable {
    
    /// The latitude of the city or location.
    let lat: Double
    
    /// The longitude of the city or location.
    let lon: Double
}
