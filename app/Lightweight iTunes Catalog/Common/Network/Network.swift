//
//  Network.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class Network {
    enum NetworkError: Error {
        case malformedRequest
    }

    private let enableLogging: Bool

    init(
        enableLogging: Bool = false
    ) {
        self.enableLogging = enableLogging
    }

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let request = endpoint.request else {
            return Fail(error: NetworkError.malformedRequest).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map { [weak self] in
                if let enableLogging = self?.enableLogging, enableLogging {
                    self?.log(data: $0.data)
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private func log(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            // Do Nothing
        }
    }
}
