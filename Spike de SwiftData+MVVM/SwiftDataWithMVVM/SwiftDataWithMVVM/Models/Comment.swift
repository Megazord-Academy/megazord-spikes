import Foundation
import SwiftData

@Model
class Comment {
    var username: String
    var title: String
    var message: String
    var date: Date
    
    init(username: String, title: String, message: String, date: Date) {
        self.username = username
        self.title = title
        self.message = message
        self.date = date
    }
}
