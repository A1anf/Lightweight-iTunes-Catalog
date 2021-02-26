//
//  ModelStorable.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/26/21.
//

import CoreData
import Foundation

protocol ModelStorable {
    var storageModelName: String { get }

    func toStorageModel(entity: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject?
}
