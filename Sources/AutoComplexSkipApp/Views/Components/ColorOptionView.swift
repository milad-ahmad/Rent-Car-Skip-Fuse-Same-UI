import SwiftUI
import SkipFuse
import SkipFuseUI

/**
 * A view representing a selectable car color option, displaying its color, name, and optional price premium.
 */
public struct ColorOptionView: View {
    let color: CarColor
    let isSelected: Bool
    let action: @MainActor @Sendable () -> Void
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(Color(hex: color.hexCode))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(Color.luxuryGold, lineWidth: isSelected ? 3 : 0)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 4)
                
                Text(color.name)
                    .font(.caption)
                    .foregroundColor(.textPrimary)
                
                if color.pricePremium > 0 {
                    Text("+$\(Int(color.pricePremium))")
                        .font(.caption2)
                        .foregroundColor(.luxuryGold)
                }
            }
        }
    }
}
