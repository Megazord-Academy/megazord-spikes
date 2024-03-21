import Foundation
import SwiftData

protocol DataSource {
    var modelContainer: ModelContainer {get}
    var modelContext: ModelContext {get}
    
    func append<T>(element: T) where T: PersistentModel
    func fetch<T>() -> [T] where T: PersistentModel
    func remove<T>(_ element: T) where T: PersistentModel
}

extension DataSource {
    func append<T>(element: T) where T: PersistentModel {
        modelContext.insert(element)
    }

    func fetch<T>() -> [T] where T: PersistentModel {
        do {
            return try modelContext.fetch(FetchDescriptor<T>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func remove<T>(_ element: T) where T: PersistentModel {
        modelContext.delete(element)
    }
}
