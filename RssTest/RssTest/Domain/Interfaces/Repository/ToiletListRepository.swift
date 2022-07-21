//
//  ToiletListRepository.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

protocol ToiletListRepository {
    func fetchToiletList(completion: @escaping(Result<[ToiletDTO], NetworkError>) -> Void)
}
