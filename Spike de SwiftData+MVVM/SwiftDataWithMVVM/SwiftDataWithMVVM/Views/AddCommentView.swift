import SwiftUI

struct AddCommentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var addCommentViewModel = AddCommentViewModel()
    
    var body: some View {
        VStack {
            Form {
                TextField("Usuário", text: $addCommentViewModel.username)
                TextField("Título", text: $addCommentViewModel.title)
                Section("Comentário") {
                    TextEditor(text: $addCommentViewModel.message)
                }
            }
            Button {
                addCommentViewModel.appendItem()
                dismiss()
            } label: {
                Label("Adicionar", systemImage: "plus")
            }
        }
    }
}

#Preview {
    AddCommentView()
}
