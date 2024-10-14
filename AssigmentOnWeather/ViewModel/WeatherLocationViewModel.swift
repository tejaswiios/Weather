//
//  WeatherLocationViewModel.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/11/24.
//

import Foundation
import Combine
import CoreLocation

/// A ViewModel responsible for managing location-related functionalities for weather services.
/// This class conforms to the `ObservableObject` protocol, allowing SwiftUI views to subscribe
/// to changes in location and authorization status.
class WeatherLocationViewModel: ObservableObject {
    
    /// The current user's location as a `CLLocation` object.
    @Published var location: CLLocation?
    
    /// The current authorization status for location services.
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    /// An instance of `WeatherLocationServiceModel`, responsible for handling location updates and permissions.
    private var locationService: WeatherLocationServiceModel
    
    /// Initializes the ViewModel with an optional `WeatherLocationServiceModel`.
    /// - Parameter locationService: An instance of `WeatherLocationServiceModel`.
    /// If none is provided, a new instance will be created.
    init(locationService: WeatherLocationServiceModel = WeatherLocationServiceModel()) {
        self.locationService = locationService
        
        // Set up the closure to update location when it's changed
        self.locationService.didUpdateLocation = { [weak self] location in
            self?.location = location
        }
        
        // Set up the closure to update authorization status when it changes
        self.locationService.didChangeAuthorizationStatus = { [weak self] authorizationStatus in
            self?.authorizationStatus = authorizationStatus
        }
    }
    
    /// Requests permission to access the user's location.
    /// This method triggers a prompt asking the user for permission.
    func requestPremission() {
        locationService.requestAppLocationPremission()
    }
    
    /// Starts the process of fetching the user's current location.
    /// This method should be called after the user has granted location permission.
    func fetchLocation() {
        locationService.requestAppLocation()
    }
}

