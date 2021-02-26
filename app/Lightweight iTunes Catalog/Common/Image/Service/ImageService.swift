//
//  ImageService.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/26/21.
//

import Combine
import UIKit

class ImageService: Service {
    enum ServiceError: Error {
        case malformedImage
    }

    private var networkCancellable: AnyCancellable?

    func load(imageUrl: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        networkCancellable = URLSession.shared.dataTaskPublisher(for: imageUrl)
            .map {
                UIImage(data: $0.data) ?? nil
            }
            .mapError { $0 as Error }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    Service.handleCompletion(result: result, completion: completion)
                },
                receiveValue: { image in
                    if let image = image {
                        completion(.success(image))
                    } else {
                        completion(.failure(ServiceError.malformedImage))
                    }
                })
    }
}

