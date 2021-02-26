//
//  SearchResultResponse.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import Foundation

struct SearchResultResponse: Codable {
    struct Item: Codable {
        let id: Int
        let name: String
        let artwork: URL?
        let genre: String
        let url: URL
    }
    
    let movie: [Item]
    let podcast: [Item]
    let music: [Item]
    let musicVideo: [Item]
    let audiobook: [Item]
    let shortFilm: [Item]
    let tvShow: [Item]
    let software: [Item]
    let ebook: [Item]
}
