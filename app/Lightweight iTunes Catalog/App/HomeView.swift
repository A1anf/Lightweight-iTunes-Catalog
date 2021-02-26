//
//  HomeView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        VStack(spacing: .zero) {
            topBar
            content
        }
    }

    private var topBar: some View {
        VStack(spacing: .zero) {
            SearchBarView(text: $viewModel.searchTerm)
                .padding()
            
            Divider()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .idle:
            FavoriteView(viewModel: viewModel.favoriteViewModel)
        case .searching:
            SearchView(viewModel: viewModel.searchViewModel)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
