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
    func execute(completion: @escaping (Result<[Toilet], DomainError>) -> Void) {
        
    }
}
