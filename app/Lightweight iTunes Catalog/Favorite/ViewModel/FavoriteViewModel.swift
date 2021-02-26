//
//  FavoriteListViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class FavoriteViewModel: ObservableObject {
    enum ViewState {
        case empty
        case loading
        case presenting(SearchResultDictionary)
        case error(Error)
    }

    @Published var viewState: ViewState = .loading

    private let service: FavoriteService
    private var cancellables: Set<AnyCancellable>

    init(service: FavoriteService = FavoriteService()) {
        self.service = service
        self.cancellables = []

        setupObservables()
    }

    func onViewAppear() {
        loadFavorites()
    }

    private func setupObservables() {
        FavoriteService.unFavoritePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] unFavoriteSearchResult in
                guard let self = self else { return }
                self.removeItem(unFavoriteSearchResult)
            }
            .store(in: &cancellables)
    }

    private func loadFavorites() {
        viewState = .loading
        service.loadAll { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResultDictionary):
                self.viewState = self.viewState(for: searchResultDictionary)
            case .failure(let error):
                self.viewState = .error(error)
            }
        }
    }

    private func viewState(for searchResultDictionary: SearchResultDictionary) -> ViewState {
        if searchResultDictionary.isEmpty {
            return .empty
        } else {
            return .presenting(searchResultDictionary)
        }
    }

    private func removeItem(_ item: SearchResult) {
        guard case ViewState.presenting(var searchResultDictionary) = viewState else {
            return
        }

        let removalType = item.type
        let removalId = item.id

        searchResultDictionary[removalType]?.removeAll(where: { $0.id == removalId })
        viewState = viewState(for: searchResultDictionary)
    }
}
