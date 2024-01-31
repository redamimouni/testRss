//
//  ToiletListRepositoryMock.swift
//  RssTestTests
//
//  Created by Reda Mimouni on 22/07/2022.
//

import Foundation
@testable import RssTest

class ToiletListRepositoryMock: ToiletListRepository {
    var mockedResult: Result<[ToiletDTO], NetworkError>?

    func fetchToiletList(completion: @escaping (Result<[ToiletDTO], NetworkError>) -> Void) {
        guard let result = mockedResult else { return }
        completion(result)
    }
}
