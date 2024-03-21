import Foundation
import SwiftData

@Observable
class AddCommentViewModel {
    @ObservationIgnored
    private let dataSource: CommentDataSource

    var username: String = ""
    var title: String = ""
    var message: String = ""
    
    init(dataSource: CommentDataSource = CommentDataSource.shared) {
        self.dataSource = dataSource
    }

    func appendItem() {
        dataSource.append(element: Comment(username: username, title: title, message: message, date: Date()))
    }
}
