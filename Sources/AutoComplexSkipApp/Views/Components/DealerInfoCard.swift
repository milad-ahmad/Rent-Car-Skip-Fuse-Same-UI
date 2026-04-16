import SwiftUI
import SkipFuse
import SkipFuseUI

/**
 * A card view displaying summary information for a dealer location.
 */
public struct DealerInfoCard: View {
    let dealer: DealerLocation
    @Environment(\.openURL) internal var openURL
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "building.2.fill")
                    .foregroundColor(.luxuryGold)
                Text(dealer.name)
                    .font(.headline)
                    .foregroundColor(.textPrimary)
                
                Spacer()
                
                RatingView(rating: dealer.rating, size: 14)
            }
            
            Text(dealer.fullAddress)
                .font(.subheadline)
                .foregroundColor(.textSecondary)
            
            HStack {
                Label(dealer.phone, systemImage: "phone.fill")
                Spacer()
                Label("Open until 8 PM", systemImage: "clock.fill")
            }
            .font(.caption)
            .foregroundColor(.textSecondary)
            
            Button(action: {
                openMaps()
            }) {
                HStack {
                    Image(systemName: "map.fill")
                    Text("Get Directions")
                }
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.luxuryGold)
                .clipShape(Capsule())
            }
        }
        .padding()
        .background(Color.surfacePrimary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    /**
     * Opens the platform's default map application using the dealer's address.
     */
    public func openMaps() {
        let encodedAddress = dealer.fullAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "maps://?q=\(encodedAddress)") {
            openURL(url)
        }
    }
}
