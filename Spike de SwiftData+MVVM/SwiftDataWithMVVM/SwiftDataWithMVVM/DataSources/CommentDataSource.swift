import Foundation
import SwiftData

final class CommentDataSource: DataSource {    
    let modelContainer: ModelContainer
    let modelContext: ModelContext

    @MainActor
    static let shared = CommentDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Comment.self)
        self.modelContext = modelContainer.mainContext
    }
}
