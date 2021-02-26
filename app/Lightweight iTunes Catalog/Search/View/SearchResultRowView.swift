//
//  SearchResultRowView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct SearchResultRowView: View {
    @ObservedObject var viewModel: SearchResultRowViewModel

    @Environment(\.openURL) var openURL
    
    var body: some View {
        Button(
            action: {
                if let url = viewModel.detailUrl { openURL(url) }
            },
            label: {
                VStack(alignment: .leading, spacing: 8) {
                    image
                    text
                    favoriteButton
                }
            })
            .buttonStyle(PlainButtonStyle())
            .onAppear {
                viewModel.viewAppeared()
            }
    }

    @ViewBuilder
    private var image: some View {
        if let url = viewModel.imageUrl {
            ImageView(viewModel: ImageViewModel(url: url), imageWidth: 100, imageHeight: 100)
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.secondary)
                .frame(width: 100, height: 100)
        }
    }

    private var text: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.caption)
                .foregroundColor(.primary)
                .frame(width: 100, alignment: .leading)
            
            Text(viewModel.subtitle)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .font(.caption2)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
        }
    }

    private var favoriteButton: some View {
        Button(
            action: { viewModel.toggleFavorite() },
            label: {
                Image(symbol: viewModel.isFavorite ? .heartFill : .heart)
                    .font(.body)
                    .foregroundColor(.blue)
            })
            .buttonStyle(PlainButtonStyle())
    }
}

struct SearchResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultRowView(
            viewModel: SearchResultRowViewModel(
                searchResult: SearchResult(
                    id: 1,
                    type: .audiobook,
                    name: "Awesome Audiobook",
                    artwork: nil,
                    genre: "Fiction",
                    url: URL(string: "https://google.com")!,
                    isFavorite: false)))
    }
}
