//
//  ToiletListPresenter.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

protocol ToiletListDelegate: NSObjectProtocol {
    func displayToiletList(toilets: [ToiletViewModel])
    func displayError(message: String)
}

final class ToiletListPresenter {
    weak var delegate: ToiletListDelegate?

    func fetchToiletList() {
        delegate?.displayToiletList(toilets: [
            ToiletViewModel(
                address: "11 rue griffhueles, Villejuf",
                openingHour: "8:00/23:00",
                isPrmFriendly: true,
                distance: "15 Km"),
            ToiletViewModel(
                address: "11 rue griffhueles, Villejuf",
                openingHour: "8:00/23:00",
                isPrmFriendly: true,
                distance: "15 Km"),
            ToiletViewModel(
                address: "11 rue griffhueles, Villejuf",
                openingHour: "8:00/23:00",
                isPrmFriendly: true,
                distance: "15 Km"),
            ToiletViewModel(
                address: "11 rue griffhueles, Villejuf",
                openingHour: "8:00/23:00",
                isPrmFriendly: true,
                distance: "15 Km")
        ])
    }

}
