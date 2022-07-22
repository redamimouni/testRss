//
//  LocationManager.swift
//  RssTest
//
//  Created by Reda Mimouni on 21/07/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationResult: LocationResult?

    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            locationResult = .locationAvailable(location: location)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        locationResult = .locationUnavailable
    }
}

enum LocationResult {
    case locationAvailable(location: CLLocation)
    case locationUnavailable
}
