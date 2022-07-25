//
//  ToiletListPresenter.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

final class ToiletListPresenter {
    private let useCase: ToiletListUseCase
    private let locationManager: LocationManager

    init(useCase: ToiletListUseCase, locationManager: LocationManager) {
        self.useCase = useCase
        self.locationManager = locationManager
    }

    func fetchToiletList(completion: @escaping (Result<[ToiletViewModel], DomainError>) -> Void) {
        useCase.execute { result in
            switch result {
            case .success(let toilets):
                self.locationManager.getActualLocation { locationStatus in
                    self.handleLocationStatus(
                        locationStatus: locationStatus,
                        toilets: toilets,
                        completion: completion
                    )
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func handleLocationStatus(locationStatus: LocationResult, toilets: [Toilet], completion: @escaping (Result<[ToiletViewModel], DomainError>) -> Void) {
        switch locationStatus {
        case .locationAvailable(location: let location):
            completion(.success(toilets.map({ $0.toViewModel(with: location) })))
        case .locationUnavailable:
            completion(.success(toilets.map({ $0.toViewModel(with: nil) })))
        }
    }
}
