//
//  SearchView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        switch viewModel.viewState {
        case .idle:
            Color.secondary
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .empty:
            EmptyStateView(symbol: .magnifyingGlass, text: "No results")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loading:
            LoadingStateView(text: "Searching")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error:
            ErrorStateView(symbol: .exclamationMarkSquare, text: "Error")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .results(let results):
            SearchResultView<EmptyView>(viewModel: SearchResultViewModel(results: results))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
