import SwiftUI
import SkipFuse
import SkipFuseUI

/**
 * A wrapper around AsyncImage and Image that handles both remote URLs and local assets.
 */
public struct AppImage: View {
    public let source: String
    public var contentMode: ContentMode = .fill
    
    public enum ContentMode {
        case fill, fit
    }
    
    public init(source: String, contentMode: ContentMode = .fill) {
        self.source = source
        self.contentMode = contentMode
    }
    
    public var body: some View {
        if source.hasPrefix("http://") || source.hasPrefix("https://") {
            AsyncImage(url: URL(string: source)) { (phase: AsyncImagePhase) in
                switch phase {
                case .empty:
                    ProgressView().tint(.luxuryGold)
                case .success(let image):
                    configureImage(image)
                case .failure:
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            configureImage(Image(source))
        }
    }
    
    @ViewBuilder
    public func configureImage(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: self.contentMode == .fill ? SwiftUI.ContentMode.fill : SwiftUI.ContentMode.fit)
    }
    
    public var placeholderImage: some View {
        Rectangle()
            .fill(Color.surfaceSecondary)
            .overlay(
                Image(systemName: "car.fill")
                    .foregroundColor(.luxuryGold.opacity(0.5))
            )
    }
}
