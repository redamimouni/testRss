//
//  ToiletViewModel.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

struct ToiletViewModel: Equatable {
    let address: String
    let openingHour: String
    let isPrmFriendly: Bool
    let distance: String
}

extension Toilet {
    func toViewModel() -> ToiletViewModel {
        return ToiletViewModel(
            address: address,
            openingHour: openTime,
            isPrmFriendly: pmrAccess,
            distance: "Distance"
        )
    }
}
