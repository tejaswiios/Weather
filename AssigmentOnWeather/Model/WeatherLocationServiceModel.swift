//
//  WeatherLocationServiceModel.swift
//  AssigmentOnWeather
//
//  Created by Tejaswi Tipparti on 10/11/24.
//

import Foundation
import CoreLocation

/// A model class that manages location services using Core Location.
/// It requests location permissions, starts location updates, and handles location updates.
class WeatherLocationServiceModel: NSObject, CLLocationManagerDelegate {
    /// The location manager instance used to manage location services.
    private let locationManager: CLLocationManager
    
    /// The current location of the device.
    private var location: CLLocation?
    
    /// A closure that gets called with the updated location when the location is updated.
    var didUpdateLocation: ((CLLocation) -> Void)?
    
    /// A closure that gets called when the authorization status changes.
    var didChangeAuthorizationStatus: ((CLAuthorizationStatus) -> Void)?
    
    /// Initializes a new instance of the `WeatherLocationServiceModel`.
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self // Set the delegate to handle location updates
    }
    
    /// Requests permission to access the device's location when the app is in use.
    func requestAppLocationPremission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// Starts updating the device's location.
    func requestAppLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    /// Called when the location manager receives updated location data.
    /// - Parameters:
    ///   - manager: The location manager that generated the update.
    ///   - locations: An array of locations.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return } // Get the most recent location
        self.location = location
        didUpdateLocation?(location) // Call the closure with the updated location
    }
    
    /// Called when the location manager's authorization status changes.
    /// - Parameters:
    ///   - manager: The location manager that generated the update.
    ///   - status: The new authorization status.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeAuthorizationStatus?(status) // Call the closure with the new authorization status
    }
    
    /// Called when the location manager fails to retrieve a location.
    /// - Parameters:
    ///   - manager: The location manager that generated the update.
    ///   - error: The error that occurred.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error in fetching location: \(error.localizedDescription)") // Print the error message
    }
}
