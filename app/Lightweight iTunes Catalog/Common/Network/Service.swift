//
//  Service.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class Service {
    var cancellables: Set<AnyCancellable> = []

    static func handleCompletion<T>(result: Subscribers.Completion<Error>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .finished:
            break
        }
    }
}
