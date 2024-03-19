import SwiftUI

class OSDetailsViewModel: ObservableObject {
    @Published var os: OS
    
    init() {
        #if os(iOS)
        os = OS(name: "iOS", releaseYear: "2007", image: "globe")
        #elseif os(visionOS)
        os = OS(name: "visionOS", releaseYear: "2023", model: "Scene")
        #else
        os = OS(name: "unknown", releaseYear: "unknown", image: "globe")
        #endif
    }
}
