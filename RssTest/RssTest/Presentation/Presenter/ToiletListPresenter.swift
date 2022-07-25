//
//  ToiletListPresenter.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

final class ToiletListPresenter {
    private let useCase: ToiletListUseCase
    private let location = LocationManager()

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToiletList(completion: @escaping (Result<[ToiletViewModel], DomainError>) -> Void) {
        useCase.execute { result in
            switch result {
            case .success(let toilets):
                self.location.getActualLocation { location in
                    completion(.success(toilets.map({ $0.toViewModel(with: location) })))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
