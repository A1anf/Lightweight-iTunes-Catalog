//
//  SearchResult.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import CoreData
import Foundation

struct SearchResult: Codable, Identifiable {
    var id: Int
    var type: SearchResultType
    var name: String
    var artwork: URL?
    var genre: String
    var url: URL
    var isFavorite: Bool
}

extension SearchResultResponse.Item {
    func toSearchResult(type: SearchResultType, isFavorite: Bool) -> SearchResult {
        return SearchResult(
            id: id,
            type: type,
            name: name,
            artwork: artwork,
            genre: genre,
            url: url,
            isFavorite: isFavorite)
    }
}

extension SearchResultEntity {
    func toSearchResult() -> SearchResult {
        return SearchResult(
            id: Int(id),
            type: SearchResultType(rawValue: type)!,
            name: name,
            artwork: artwork,
            genre: genre,
            url: url,
            isFavorite: isFavorite)
    }
}

extension SearchResult: ModelStorable {
    static var storageModelName: String {
        return "SearchResultEntity"
    }

    var storageModelName: String {
        return SearchResult.storageModelName
    }

    func toStorageModel(entity: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject? {
        let searchResultEntity = SearchResultEntity(entity: entity, insertInto: context)
        searchResultEntity.id = Int64(id)
        searchResultEntity.type = type.rawValue
        searchResultEntity.name = name
        searchResultEntity.artwork = artwork
        searchResultEntity.genre = genre
        searchResultEntity.url = url
        searchResultEntity.isFavorite = isFavorite
        return searchResultEntity
    }
}
