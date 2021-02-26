//
//  SearchResultEntity+CoreDataProperties.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/25/21.
//
//

import Foundation
import CoreData

extension SearchResultEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResultEntity> {
        return NSFetchRequest<SearchResultEntity>(entityName: "SearchResultEntity")
    }

    @NSManaged public var artwork: URL?
    @NSManaged public var genre: String
    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var url: URL

}

extension SearchResultEntity : Identifiable {

}
