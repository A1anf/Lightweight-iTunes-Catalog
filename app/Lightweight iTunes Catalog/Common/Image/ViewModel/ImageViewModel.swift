//
//  ImageViewModel.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/22/21.
//

import Combine
import UIKit

class ImageViewModel: ObservableObject {
    enum ViewState {
        case loading
        case loaded(UIImage)
        case error(Error)
    }

    @Published var viewState: ViewState = .loading

    private let url: URL
    private let service: ImageService

    init(url: URL, service: ImageService = ImageService()) {
        self.url = url
        self.service = service
    }

    func onViewAppeared() {
        loadImage()
    }

    private func loadImage() {
        viewState = .loading
        service.load(imageUrl: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.viewState = .loaded(image)
            case .failure(let error):
                self.viewState = .error(error)
            }
        }
    }
}
