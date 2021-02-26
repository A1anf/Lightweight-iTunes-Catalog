//
//  FavoriteService.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/25/21.
//

import Combine
import CoreData
import Foundation

class FavoriteService: Service {
    static let unFavoritePublisher = PassthroughSubject<SearchResult, Never>()

    private let storage: Storage

    enum ServiceError: Error {
        case unableToRetrieveFavorite
    }

    init(storage: Storage = Storage()) {
        self.storage = storage
    }

    func load(id: Int, completion: @escaping (Result<SearchResult, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<SearchResultEntity>(entityName: SearchResult.storageModelName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))

        storage.fetch(request: fetchRequest)
            .map {
                $0.first?.toSearchResult() ?? nil
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { searchResult in
                    if let searchResult = searchResult {
                        completion(.success(searchResult))
                    } else {
                        completion(.failure(ServiceError.unableToRetrieveFavorite))
                    }
                })
            .store(in: &cancellables)
    }
    
    func loadAll(completion: @escaping (Result<SearchResultDictionary, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<SearchResultEntity>(entityName: SearchResult.storageModelName)

        storage.fetch(request: fetchRequest)
            .map {
                $0.toSearchResultDictionary()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { searchResults in
                    completion(.success(searchResults))
                })
            .store(in: &cancellables)
    }

    func favorite(searchResult: SearchResult, completion: @escaping (Result<Bool, Error>) -> Void) {
        storage.insert(model: searchResult)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { success in
                    completion(.success(success))
                })
            .store(in: &cancellables)
    }

    func unFavorite(searchResult: SearchResult, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<SearchResultEntity>(entityName: SearchResult.storageModelName)
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(searchResult.id))

        storage.delete(request: fetchRequest)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { success in
                    FavoriteService.unFavoritePublisher.send(searchResult)
                    completion(.success(success))
                })
            .store(in: &cancellables)
    }
}
