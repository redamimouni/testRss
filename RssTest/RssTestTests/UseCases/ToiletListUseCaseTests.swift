//
//  ToiletListUseCaseTests.swift
//  RssTestTests
//
//  Created by Reda Mimouni on 22/07/2022.
//

import XCTest
@testable import RssTest
import CoreLocation

class ToiletListUseCaseTests: XCTestCase {

    private lazy var useCase: ToiletListUseCase = {
        return ToiletListUseCaseImpl(repository: repository)
    }()
    var repository = ToiletListRepositoryMock()

    func test_execute_shouldReturnSuccess() {
        // Given
        repository.mockedResult = .success([
            ToiletDTO(
                complementAdresse: ComplementAdresse.numeroDeVoieNomDeVoie,
                geoShape: GeoShape(
                    coordinates: [[2.332917144300073, 48.83313899250652]],
                    type: .multiPoint),
                horaire: Horaire.the24H24,
                accesPmr: AccesPmr.non,
                arrondissement: 12,
                geoPoint2D: [48.83313899250652, 2.332917144300073],
                source: "http://opendata.paris.fr",
                gestionnaire: Gestionnaire.toilettePubliqueDeLaVilleDeParis,
                adresse: "1  AVENUE RENE COTY",
                type: .sanisette,
                urlFicheEquipement: nil,
                relaisBebe: nil
            )
        ])
        let expected = [Toilet(
            address: "1  AVENUE RENE COTY",
            openTime: "24 h / 24",
            pmrAccess: false,
            geolocalisation: CLLocation(
                latitude: 48.83313899250652,
                longitude: 2.332917144300073))
        ]

        // When
        useCase.execute { result in
            // Then
            switch result {
            case .success(let toilets):
                XCTAssertEqual(toilets, expected)
            case .failure(let error):
                XCTFail("Result should be success but got \(error)")
            }
        }
    }

    func test_execute_shouldReturnFailure() {
        // Given
        repository.mockedResult = .failure(.wrongUrlError)
        let expected = DomainError.networkError

        // When
        useCase.execute { result in
            // Then
            switch result {
            case .success(let toilets):
                XCTFail("Result should be success but got \(toilets)")
            case .failure(let error):
                XCTAssertEqual(error, expected)
            }
        }
    }
}
