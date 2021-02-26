//
//  SearchResultRowViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class SearchResultRowViewModel: ObservableObject {
    @Published private var searchResult: SearchResult

    private let service: FavoriteService

    init(searchResult: SearchResult, service: FavoriteService = FavoriteService()) {
        self.searchResult = searchResult
        self.service = service
    }

    var imageUrl: URL? {
        return searchResult.artwork
    }

    var title: String {
        return searchResult.name
    }

    var subtitle: String {
        return searchResult.genre
    }

    var detailUrl: URL? {
        return searchResult.url
    }

    var isFavorite: Bool {
        return searchResult.isFavorite
    }

    func viewAppeared() {
        loadFavoriteStatus()
    }

    func toggleFavorite() {
        searchResult.isFavorite = !isFavorite

        if isFavorite {
            favorite()
        } else {
            unfavorite()
        }
    }

    private func loadFavoriteStatus() {
        service.load(id: searchResult.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let storedResult):
                self.searchResult.isFavorite = storedResult.isFavorite
            case .failure:
                break // Fail silently
            }
        }
    }

    private func favorite() {
        service.favorite(searchResult: searchResult) { _ in }
    }

    private func unfavorite() {
        service.unFavorite(searchResult: searchResult) { _ in }
    }
}
