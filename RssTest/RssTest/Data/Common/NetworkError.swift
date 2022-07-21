//
//  NetworkError.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

enum NetworkError: Error {
    case httpRequestError
    case errorDataFetch
    case parsingError
    case wrongUrlError
}
