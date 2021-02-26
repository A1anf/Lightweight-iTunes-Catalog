//
//  Storage.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/25/21.
//

import Combine
import CoreData
import Foundation

class Storage {
    enum StorageError: Error {
        case storageDeInitialized
        case fetchFailed
        case deleteFailed
        case insertFailed
    }

    init() { }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppData")
        container.loadPersistentStores { _, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func fetch<T>(request: NSFetchRequest<T>) -> AnyPublisher<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    promise(.failure(StorageError.storageDeInitialized))
                    return
                }

                let context = self.backgroundContext

                do {
                    let results = try context.fetch(request)
                    promise(.success(results))
                } catch {
                    promise(.failure(StorageError.fetchFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func delete<T>(request: NSFetchRequest<T>) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { [weak self] promise in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    promise(.failure(StorageError.storageDeInitialized))
                    return
                }

                let context = self.backgroundContext

                do {
                    let results = try context.fetch(request)
                    for result in results {
                        if let managedResult = result as? NSManagedObject {
                            context.delete(managedResult)
                        }
                    }
                    try context.save()
                    promise(.success(true))
                } catch {
                    promise(.failure(StorageError.deleteFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func insert(model: ModelStorable) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { [weak self] promise in
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else {
                    promise(.failure(StorageError.storageDeInitialized))
                    return
                }

                let context = self.backgroundContext

                guard let entity = NSEntityDescription.entity(forEntityName: model.storageModelName, in: context), let storageModel = model.toStorageModel(entity: entity, context: context) else {
                    promise(.failure(StorageError.insertFailed))
                    return
                }

                context.insert(storageModel)

                do {
                    try context.save()
                    promise(.success(true))
                } catch {
                    promise(.failure(StorageError.insertFailed))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
