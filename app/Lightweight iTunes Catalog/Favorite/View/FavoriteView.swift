//
//  FavoriteView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel

    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .empty:
                EmptyStateView(symbol: .star, text: "No favorites yet")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loading:
                LoadingStateView(text: "Loading Favorites")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .presenting(let results):
                SearchResultView(viewModel: SearchResultViewModel(results: results), header: {
                    header
                })
                .id(UUID())
            case .error:
                ErrorStateView(symbol: .exclamationMarkSquare, text: "Error")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewModel.onViewAppear()
        }
    }

    private var header: some View {
        HStack {
            Image(symbol: .heartFill)
                .font(.headline)
                .foregroundColor(.blue)
            Text("Favorites")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(.vertical)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(viewModel: FavoriteViewModel())
    }
}
