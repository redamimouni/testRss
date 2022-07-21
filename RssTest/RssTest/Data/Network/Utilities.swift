//
//  Utilities.swift
//  RssTest
//
//  Created by Reda Mimouni on 21/07/2022.
//

import Foundation

extension URLSession {
    func dataTask(with url: URLRequest,
                  cachedResponse: Bool,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if cachedResponse,
                let error = error,
                let cachedResponse = self.configuration.urlCache?.cachedResponse(for: url) {

                completionHandler(cachedResponse.data, cachedResponse.response, error)
                return
            }
            completionHandler(data, response, error)
        }
    }
}

extension URLRequest {
    static func urlRequestFrom(urlString: String) -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
