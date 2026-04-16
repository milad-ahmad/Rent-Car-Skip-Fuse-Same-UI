import SkipFuse
import SkipFuseUI
import SwiftUI

/**
 * The main explore view allowing users to search, filter, and discover rental cars.
 */
public struct ExploreView: View {
    @Environment(RentalViewModel.self) var viewModel: RentalViewModel
    @State var searchText = ""
    @State var showingFilters = false
    @State var selectedCategory: CarCategory = .all
    
    public enum CarCategory: String, CaseIterable {
        case all = "All"
        case sports = "Sports"
        case luxury = "Luxury"
        case suv = "SUV"
        case electric = "Electric"
        case convertible = "Convertible"
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        HeroCarouselView(cars: viewModel.featuredCars)
                            .frame(height: 500)
                        
                        VStack(spacing: 24) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.textSecondary)
                                
                                TextField("Search for a car...", text: $searchText)
                                    .font(.body)
                                
                                Button(action: { showingFilters = true }) {
                                    Image(systemName: "slider.horizontal.3")
                                        .foregroundColor(.luxuryGold)
                                }
                            }
                            .padding()
                            .background(Color.surfacePrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.05), radius: 10)
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(CarCategory.allCases, id: \.self) { category in
                                        CategoryPill(
                                            category: category,
                                            isSelected: selectedCategory == category
                                        ) {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                selectedCategory = category
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            SectionHeader(title: "Featured Vehicles", action: {})
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.featuredCars) { car in
                                        NavigationLink(destination: CarDetailView(car: car)) {
                                            FeaturedCarCard(car: car)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            SectionHeader(
                                title: "Popular Near You",
                                action: {}
                            )
                            
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.nearbyCars) { car in
                                    NavigationLink(destination: CarDetailView(car: car)) {
                                        CarListItem(car: car)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            MembershipBanner()
                                .padding()
                        }
                        .padding(.top, 24)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "steeringwheel")
                                .font(.title2)
                                .foregroundColor(.luxuryGold)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("LUXURY WHEELS")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.luxuryGold)
                            
                            Text("Premium Car Rental")
                                .font(.caption2)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Image(systemName: "bell")
                                .foregroundColor(.textPrimary)
                        }
                        
                        NavigationLink(destination: ProfileView()) {
                            AsyncImage(url: URL(string: viewModel.currentUser?.profileImage ?? "")) { (image: Image) in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Circle()
                                    .fill(Color.surfaceSecondary)
                                    .overlay(
                                        Text(viewModel.currentUser?.name.prefix(1) ?? "G")
                                            .foregroundColor(.luxuryGold)
                                    )
                            }
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingFilters) {
            FilterView()
                .environment(viewModel)
        }
    }
}
