//
//  Toilet.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation
import CoreLocation

struct Toilet {
    let address: String
    let openTime: String
    let pmrAccess: Bool
    let geolocalisation: CLLocationCoordinate2D
}

extension ToiletDTO {
    func toDomain() -> Toilet {
        return Toilet(
            address: adresse,
            openTime: horaire.rawValue,
            pmrAccess: accesPmr.boolean,
            geolocalisation: CLLocationCoordinate2D(latitude: geoPoint2D[0], longitude:  geoPoint2D[1])
        )
    }
}
