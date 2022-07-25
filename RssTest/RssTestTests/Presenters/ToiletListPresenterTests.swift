//
//  RssTestTests.swift
//  RssTestTests
//
//  Created by Reda Mimouni on 19/07/2022.
//

import XCTest
import CoreLocation
@testable import RssTest

class ToiletListPresenterTests: XCTestCase {

    private let locationManager = LocationManager()

    func test_fetchToiletList_shouldSuccess() {
        // Given
        let useCaseMock = ToiletListUseCaseMock()
        useCaseMock.mockResult = .success([
            Toilet(
                address: "JARDIN DE LA ZAC D'ALESIA",
                openTime: "Voir fiche équipement",
                pmrAccess: true,
                geolocalisation: CLLocation(latitude: 23.1212, longitude: 32.233131)
            ),
            Toilet(
                address: "QUAI BRANLY",
                openTime: "24 h / 24",
                pmrAccess: false,
                geolocalisation: CLLocation(latitude: 23.12121, longitude: 32.4233)
            )
        ])
        let presenter = ToiletListPresenter(useCase: useCaseMock, locationManager: locationManager)

        // When
        presenter.fetchToiletList { result in
            // Then
            switch result {
            case .success(let viewModels):
                XCTAssertEqual(viewModels, [
                    ToiletViewModel(
                        address: "JARDIN DE LA ZAC D'ALESIA",
                        openingHour: "Ouverture: Voir fiche équipement",
                        isPrmFriendly: true,
                        distance: "Distance"
                    ),
                    ToiletViewModel(
                        address: "QUAI BRANLY",
                        openingHour: "Ouverture: 24 h / 24",
                        isPrmFriendly: false,
                        distance: "Distance"
                    )
                ])
            case .failure(let error):
                XCTFail("Result should be success but got \(error)")
            }
        }
    }

    func test_fetchToiletList_shouldFail() {
        // Given
        let useCaseMock = ToiletListUseCaseMock()
        useCaseMock.mockResult = .failure(.networkError)
        let presenter = ToiletListPresenter(useCase: useCaseMock, locationManager: locationManager)

        // When
        presenter.fetchToiletList { result in
            // Then
            switch result {
            case .success(let viewModels):
                XCTFail("Result should fail but got \(viewModels)")
            case .failure(let error):
                XCTAssertEqual(error, .networkError)
            }
        }
    }
}
