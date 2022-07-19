//
//  ToiletListUseCaseMock.swift
//  RssTestTests
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation
@testable import RssTest

final class ToiletListUseCaseMock: ToiletListUseCase {
    var mockResult: Result<[Toilet], DomainError>!

    func execute(completion: @escaping (Result<[Toilet], DomainError>) -> Void) {
        completion(mockResult)
    }
}
