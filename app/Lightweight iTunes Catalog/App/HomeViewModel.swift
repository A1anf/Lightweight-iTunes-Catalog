//
//  HomeViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    enum ViewState {
        case idle
        case searching
    }

    @Published var viewState: ViewState = .idle
    @Published var searchTerm: String = ""

    private(set) var favoriteViewModel: FavoriteViewModel
    private(set) var searchViewModel: SearchViewModel
    
    private var cancellables: Set<AnyCancellable>

    init() {
        self.favoriteViewModel = FavoriteViewModel()
        self.searchViewModel = SearchViewModel()
        self.cancellables = []
        
        setupObservables()
    }

    private func setupObservables() {
        $searchTerm
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTerm in
                guard let self = self else { return }
                self.searchViewModel.searchTerm = newTerm
            }
            .store(in: &cancellables)

        searchViewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchViewState in
                guard let self = self else { return }
                switch searchViewState {
                case .idle:
                    self.viewState = .idle
                case .empty, .error, .loading, .results:
                    self.viewState = .searching
                }
            }
            .store(in: &cancellables)
    }
}
