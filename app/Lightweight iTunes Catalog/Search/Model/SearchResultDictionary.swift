//
//  SearchResultDictionary.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/25/21.
//

import Foundation

typealias SearchResultDictionary = [SearchResultType: [SearchResult]]

extension SearchResultDictionary {
    init() {
        var initialDictionary: SearchResultDictionary = [:]
        for type in SearchResultType.allCases {
            initialDictionary[type] = []
        }
        self = initialDictionary
    }

    var isEmpty: Bool {
        for key in keys {
            if let results = self[key], !results.isEmpty {
                return false
            }
        }
        
        return true
    }
}

extension SearchResultResponse {
    func toSearchResultDictionary() -> SearchResultDictionary {
        let dictionary: SearchResultDictionary = [
            .movie: movie.compactMap { $0.toSearchResult(type: .movie, isFavorite: false) },
            .podcast: podcast.compactMap { $0.toSearchResult(type: .podcast, isFavorite: false) },
            .music: music.compactMap { $0.toSearchResult(type: .music, isFavorite: false) },
            .musicVideo: musicVideo.compactMap { $0.toSearchResult(type: .musicVideo, isFavorite: false) },
            .audiobook: audiobook.compactMap { $0.toSearchResult(type: .audiobook, isFavorite: false) },
            .shortFilm: shortFilm.compactMap { $0.toSearchResult(type: .shortFilm, isFavorite: false) },
            .tvShow: tvShow.compactMap { $0.toSearchResult(type: .tvShow, isFavorite: false) },
            .software: software.compactMap { $0.toSearchResult(type: .software, isFavorite: false) },
            .ebook: ebook.compactMap { $0.toSearchResult(type: .ebook, isFavorite: false) },
        ]
        return dictionary
    }
}

extension Array where Element == SearchResultEntity {
    func toSearchResultDictionary() -> SearchResultDictionary {
        var dictionary = SearchResultDictionary()
        for item in self {
            let searchResult = item.toSearchResult()
            dictionary[searchResult.type]?.append(searchResult)
        }
        return dictionary
    }
}
