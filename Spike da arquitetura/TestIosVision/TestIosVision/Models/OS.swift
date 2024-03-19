import Foundation

struct OS {
    var name: String
    var releaseYear: String
    #if os(iOS)
    var image: String
    #elseif os(visionOS)
    var model: String
    #endif
}
