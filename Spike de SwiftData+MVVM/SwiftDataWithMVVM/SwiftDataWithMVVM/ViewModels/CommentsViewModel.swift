import Foundation
import SwiftData

@Observable
class CommentsViewModel {
    @ObservationIgnored
    private let dataSource: CommentDataSource

    var comments: [Comment] = []
    var showAddComment: Bool = false
    
    var didSavePublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: Notification.Name.NSManagedObjectContextDidSave)
    }

    init(dataSource: CommentDataSource = CommentDataSource.shared) {
        self.dataSource = dataSource
    }
    
    func fetch(sortBy sortDescriptors: [SortDescriptor<Comment>] = []) {
        comments = dataSource.fetch(sortBy: sortDescriptors)
    }

    func remove(_ comment: Comment) {
        dataSource.remove(comment)
    }
}
