//
//  ToiletListUseCase.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

protocol ToiletListUseCase {
    func execute(completion: @escaping(Result<[Toilet], DomainError>) -> Void)
}

final class ToiletListUseCaseImpl: ToiletListUseCase {
    private let repository: ToiletListRepository

    init(repository: ToiletListRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[Toilet], DomainError>) -> Void) {
        repository.fetchToiletList { result in
            switch result {
            case .success(let toiletList):
                completion(.success(toiletList.map({ $0.toDomain() })))
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
}
