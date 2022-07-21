//
//  ToiletListRepositoryImpl.swift
//  RssTest
//
//  Created by Reda Mimouni on 19/07/2022.
//

import Foundation

final class ToiletListRepositoryImpl: ToiletListRepository {
    func fetchToiletList(completion: @escaping (Result<[ToiletDTO], NetworkError>) -> Void) {
        guard let request = URLRequest.urlRequestFrom(urlString: APIEndpoints.listing.rawValue) else {
            completion(.failure(.wrongUrlError))
            return
        }
        let task = URLSession.shared.dataTask(with: request, cachedResponse: true) { [weak self] data, response, error in
            if let _ = error {
                completion(.failure(.httpRequestError))
            }
            guard let data = data else {
                completion(.failure(.errorDataFetch))
                return
            }
            print("HTTP Status code: \((response as! HTTPURLResponse).statusCode)")
            self?.decodeEntityFromData(data: data, completion: completion)
        }
        task.resume()
    }

    private func decodeEntityFromData(data: Data, completion: @escaping (Result<[ToiletDTO], NetworkError>) -> Void) {
        do {
            let jsonFromData = try JSONDecoder().decode(RootToiletDTO.self, from: data)
            completion(.success(jsonFromData.records.map({ $0.fields })))
        } catch {
            print("Error took place\(error)")
            completion(.failure(.parsingError))
        }
    }
}
