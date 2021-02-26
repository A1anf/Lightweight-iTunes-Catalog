//
//  Endpoint.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Foundation

enum Endpoint {
    case search(term: String)
    
    var request: URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.port = port
        urlComponents.queryItems = queryItems

        return urlComponents.url
    }
    
    private var scheme: String {
        switch self {
        default:
            return "http"
        }
    }
    
    private var host: String {
        switch self {
        default:
            return "127.0.0.1"
        }
    }
    
    private var port: Int {
        switch self {
        default:
            return 3333
        }
    }
    
    private var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let searchTerm):
            return [
                URLQueryItem(name: "term", value: searchTerm)
            ]
        }
    }
}
