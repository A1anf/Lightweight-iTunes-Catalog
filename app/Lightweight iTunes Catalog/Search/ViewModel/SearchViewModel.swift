//
//  SearchViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    enum ViewState {
        case idle
        case empty
        case loading
        case error(Error)
        case results(SearchResultDictionary)
    }

    @Published var viewState: ViewState
    @Published var searchTerm: String

    private let service: SearchService
    private var cancellables: Set<AnyCancellable>

    init(service: SearchService = SearchService()) {
        self.viewState = .idle
        self.searchTerm = ""
        self.service = service
        self.cancellables = []
        
        setupObservables()
    }

    private func setupObservables() {
        $searchTerm
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTerm in
                guard let self = self else { return }
                self.search()
            }
            .store(in: &cancellables)
    }

    private func search() {
        if searchTerm.isEmpty {
            viewState = .idle
            return
        }

        viewState = .loading
        service.loadResults(term: searchTerm) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResultDictionary):
                if searchResultDictionary.isEmpty {
                    self.viewState = .empty
                } else {
                    self.viewState = .results(searchResultDictionary)
                }
            case .failure(let error):
                self.viewState = .error(error)
            }
        }
    }
}
