import SwiftUI
import RealityKit

#if os(visionOS)
import RealityKitContent
#endif

struct OSDetailsView: View {
    @StateObject private var osDetailsViewModel = OSDetailsViewModel()

    var body: some View {
        VStack {
            #if os(visionOS)
            RealityView { content in
                let model = try! await Entity(named: osDetailsViewModel.os.model, in: RealityKitContent.realityKitContentBundle)
                content.add(model)
            }
            #else
            Image(systemName: osDetailsViewModel.os.image)
                .imageScale(.large)
                .foregroundStyle(.tint)
            #endif
            
            Text(osDetailsViewModel.os.name)
            Text("\(osDetailsViewModel.os.releaseYear)")
        }
        .padding()
    }
}

#Preview {
    OSDetailsView()
}
