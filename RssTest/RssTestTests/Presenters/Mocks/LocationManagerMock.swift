//
//  LocationManagerMock.swift
//  RssTestTests
//
//  Created by Reda Mimouni on 25/07/2022.
//

import Foundation
import CoreLocation
@testable import RssTest

class LocationManagerMock: LocationManager {
    var expectedResult: LocationResult!

    func getActualLocation(callback: @escaping LocateMeCallback) {
        callback(expectedResult)
    }

}
