//
//  LocationManager.swift
//  RssTest
//
//  Created by Reda Mimouni on 21/07/2022.
//

import Foundation
import CoreLocation

typealias LocateMeCallback = (_ location: LocationResult) -> Void

protocol LocationManager {
    func getActualLocation(callback: @escaping LocateMeCallback)
}

class LocationManagerImpl: NSObject, LocationManager {

    private var lastLocation: CLLocation?

    private  var locationCallback: LocateMeCallback?

    private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.activityType = .automotiveNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()

    // MARK: Init

    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    // MARK: Public

    func getActualLocation(callback: @escaping LocateMeCallback) {
        locationCallback = callback
        if let historyLocation = lastLocation {
            callback(.locationAvailable(location: historyLocation))
        } else {
            enableLocationServices()
        }
    }

    // MARK: Private

    private func enableLocationServices() {
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Fail permission to get current location of user")
            locationCallback?(.locationUnavailable)
        case .authorizedWhenInUse, .authorizedAlways:
            enableMyWhenInUseFeatures()
        default:
            locationCallback?(.locationUnavailable)
        }
    }

    private func enableMyWhenInUseFeatures() {
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManagerImpl: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        lastLocation = location
        locationCallback?(.locationAvailable(location: location))
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
        locationCallback?(.locationUnavailable)
    }
}

enum LocationResult {
    case locationAvailable(location: CLLocation)
    case locationUnavailable
}
