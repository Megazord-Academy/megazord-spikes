import SwiftUI

@main
struct SwiftDataWithMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CommentsView()
            }
        }
    }
}
