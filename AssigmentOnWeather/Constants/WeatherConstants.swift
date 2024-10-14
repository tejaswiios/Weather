//
//  WeatherConstants.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/12/24.
//

import Foundation

// API Key for accessing OpenWeatherMap services.
let weatherAPIKey = "944779edb027da6d5f6dba34eef20e22"

// Base URL for OpenWeatherMap's Geo API.
// This is used for fetching location data based on city names.
let geoBaseUrl = "https://api.openweathermap.org/geo/1.0/direct?q="

// Part of the URL query that limits the number of results to 5 and appends the API key.
let baseURLAPIKey = "&limit=5&appid="

// Base URL for the Weather API provided by OpenWeatherMap.
// This URL is used to fetch weather data based on geographical coordinates.
let weatherBaserUrl = "https://api.openweathermap.org/data/2.5/weather?"

// Part of the query URL that indicates latitude.
// This is used in combination with `lonURL` to specify the location for weather data.
let latURL = "lat="

// Part of the query URL that indicates longitude.
// This follows `latURL` in the query and is used to provide location coordinates for fetching weather data.
let lonURL = "&lon="

// Base URL for fetching weather condition icons from OpenWeatherMap.
// The API returns a weather icon code, which is appended to this URL to retrieve the icon image.
let cacheImageURL = "https://openweathermap.org/img/wn/"

// Image file extension for the weather icons fetched from OpenWeatherMap.
// Icons are returned with a `@2x.png` suffix, which represents the image size.
let extensionImage = "@2x.png"
