import SwiftUI
import SkipFuse
import SkipFuseUI

/**
 * Pill component for category selection.
 */
public struct CategoryPill: View {
    let category: ExploreView.CarCategory
    let isSelected: Bool
    let action: @MainActor @Sendable () -> Void
    
    public var body: some View {
        Button(action: action) {
            Text(category.rawValue)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .black : .textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.luxuryGold : Color.surfacePrimary)
                )
                .overlay(
                    Capsule()
                        .stroke(Color.luxuryGold.opacity(0.3), lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}
