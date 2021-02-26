//
//  SearchService.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class SearchService: Service {
    private var network: Network
    private var networkCancellable: AnyCancellable?

    init(network: Network = Network()) {
        self.network = network
    }

    func loadResults(term: String, completion: @escaping (Result<SearchResultDictionary, Error>) -> Void) {
        networkCancellable = network.fetch(SearchResultResponse.self, from: .search(term: term))
            .map {
                $0.toSearchResultDictionary()
            }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { searchResultDictionary in
                    completion(.success(searchResultDictionary))
                })
    }
}
