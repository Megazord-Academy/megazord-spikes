import SwiftUI

struct CommentsView: View {
    @State private var commentsViewModel = CommentsViewModel()
    
    var body: some View {
        VStack {
            Button {
                commentsViewModel.showAddComment = true
            } label: {
                Label("Adicionar Comentário", systemImage: "plus")
            }
            List {
                ForEach(commentsViewModel.comments) { comment in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(comment.title)
                            Spacer()
                            Text(comment.date.formatted())
                        }
                        Text(comment.username)
                        HStack {
                            Text(comment.message)
                        }
                    }
                    .swipeActions {
                        Button {
                            commentsViewModel.remove(comment)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $commentsViewModel.showAddComment) {
            AddCommentView()
        }
        .onReceive(commentsViewModel.didSavePublisher, perform: { _ in
            print("DIDSAVE")
            commentsViewModel.fetch(sortBy: [SortDescriptor(\.date)])
        })
    }
}

#Preview {
    CommentsView()
}
