//
//  ImageView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/22/21.
//

import SwiftUI

struct ImageView: View {
    @StateObject var viewModel: ImageViewModel

    var imageWidth: CGFloat
    var imageHeight: CGFloat

    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .loading:
                LoadingStateView()
                    .frame(width: imageWidth, height: imageHeight)
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageHeight)
            case .error:
                Image(symbol: .exclamationMarkSquare)
                    .foregroundColor(.secondary)
                    .frame(width: imageWidth, height: imageHeight)
            }
        }
        .onAppear {
            viewModel.onViewAppeared()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(viewModel: ImageViewModel(url: URL(string: "https://google.com")!), imageWidth: 50, imageHeight: 50)
    }
}
