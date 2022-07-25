//
//  ToiletViewModel.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation
import CoreLocation

struct ToiletViewModel: Equatable {
    let address: String
    let openingHour: String
    let isPrmFriendly: Bool
    let distance: String
}

extension Toilet {
    func toViewModel(with location: CLLocation?) -> ToiletViewModel {
        return ToiletViewModel(
            address: address,
            openingHour: "Ouverture: \(openTime)",
            isPrmFriendly: pmrAccess,
            distance: calculateDistanceFrom(toilet: location)
        )
    }

    private func calculateDistanceFrom(toilet location: CLLocation?) -> String {
        if let distance = location?.distance(from: geolocalisation) {
            var distanceString: String
            if distance > 999 {
                distanceString = "\(String(format:"%.02f", distance / 1000)) km"
            } else {
                distanceString = "\(String(format:"%.02f", distance)) m"
            }
            return "Distance: \(distanceString)"
        }
        return "Distance inconnu"
    }
}
