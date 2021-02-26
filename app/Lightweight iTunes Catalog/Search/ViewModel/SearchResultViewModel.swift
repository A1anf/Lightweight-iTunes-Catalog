//
//  SearchResultViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Foundation

class SearchResultViewModel: ObservableObject {
    private let results: SearchResultDictionary

    init(results: SearchResultDictionary) {
        self.results = results
    }

    var availableTypeSections: [SearchResultType] {
        return results.compactMap { return $0.value.isEmpty ? nil : $0.key }
    }

    func title(for type: SearchResultType) -> String {
        switch type {
        case .movie: return "Movie"
        case .podcast: return "Podcast"
        case .music: return "Music"
        case .musicVideo: return "Music Video"
        case .audiobook: return "Audio Book"
        case .shortFilm: return "Short Film"
        case .tvShow: return "TV Show"
        case .software: return "Software"
        case .ebook: return "Ebook"
        }
    }

    func results(for type: SearchResultType) -> [SearchResult] {
        return results[type] ?? []
    }
}
