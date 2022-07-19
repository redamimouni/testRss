//
//  ToiletListPresenter.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

final class ToiletListPresenter {
    private let useCase: ToiletListUseCase

    init(useCase: ToiletListUseCase) {
        self.useCase = useCase
    }

    func fetchToiletList(completion: @escaping (Result<[ToiletViewModel], DomainError>) -> Void) {
        useCase.execute { result in
            switch result {
            case .success(let toilets):
                completion(.success(toilets.map({ $0.toViewModel() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
