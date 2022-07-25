//
//  LocationManager.swift
//  RssTest
//
//  Created by Reda Mimouni on 21/07/2022.
//

import Foundation
import CoreLocation

typealias LocateMeCallback = (_ location: CLLocation?) -> Void

class LocationManager: NSObject {

    private var lastLocation: CLLocation?

    private  var locateMeCallback: LocateMeCallback?

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

    func getActualLocation(distanceFilter: CLLocationDistance = 500, callback: @escaping LocateMeCallback) {
        self.locationManager.distanceFilter = distanceFilter
        self.locateMeCallback = callback
        if lastLocation == nil {
            enableLocationServices()
        } else {
            callback(lastLocation)
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
        case .authorizedWhenInUse, .authorizedAlways:
            enableMyWhenInUseFeatures()
        default:
            break
        }
    }

    private func enableMyWhenInUseFeatures() {
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        lastLocation = location
        self.locateMeCallback?(location)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
}
