//
//  HomeView.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI

struct Car: Identifiable {
    let id = UUID()
    let make: String
    let model: String
    let year: Int
    let price: Double
    let mileage: Int
    let imageURL: String
    var isFavorite: Bool = false
}

struct HomeView: View {
    // Sample data
    @State private var cars: [Car] = [
        Car(make: "Toyota", model: "Camry", year: 2023, price: 28500, mileage: 5, imageURL: "car1"),
        Car(make: "Honda", model: "Accord", year: 2022, price: 27800, mileage: 12000, imageURL: "car2"),
        Car(make: "Ford", model: "Mustang", year: 2023, price: 42000, mileage: 3000, imageURL: "car3"),
        Car(make: "Chevrolet", model: "Equinox", year: 2021, price: 25400, mileage: 18000, imageURL: "car4"),
        Car(make: "BMW", model: "3 Series", year: 2022, price: 45900, mileage: 9000, imageURL: "car5"),
        Car(make: "Tesla", model: "Model 3", year: 2023, price: 51000, mileage: 2000, imageURL: "car6")
    ]
    
    @State private var searchText: String = ""
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home, favorites, profile
    }
    
    var filteredCars: [Car] {
        if searchText.isEmpty {
            return cars
        } else {
            return cars.filter { car in
                car.make.lowercased().contains(searchText.lowercased()) ||
                car.model.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var filteredFavoriteCars: [Car] {
        if searchText.isEmpty {
            return cars.filter { $0.isFavorite }
        } else {
            return cars.filter { car in
                car.isFavorite && (
                    car.make.lowercased().contains(searchText.lowercased()) ||
                    car.model.lowercased().contains(searchText.lowercased())
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Navigation title area
                HStack {
                    Text(tabTitle)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                // Custom search bar with fixed margins
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color.white)
                
                // Content area - All views are always in the hierarchy
                ZStack {
                    // Home tab - Car listing
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            // Add a spacer at the top to give breathing room
                            Spacer()
                                .frame(height: 8)
                                
                            ForEach(filteredCars) { car in
                                CarCardView(car: car) {
                                    // Toggle favorite
                                    if let index = cars.firstIndex(where: { $0.id == car.id }) {
                                        cars[index].isFavorite.toggle()
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // Add spacing at the bottom
                            Spacer()
                                .frame(height: 16)
                        }
                    }
                    .opacity(selectedTab == .home ? 1 : 0)
                    .animation(.none, value: selectedTab)
                    
                    // Favorites tab
                    ZStack {
                        if filteredFavoriteCars.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No favorites yet")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                Text("Save your favorite cars to view them here")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                        } else {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    // Add a spacer at the top
                                    Spacer()
                                        .frame(height: 8)
                                        
                                    ForEach(filteredFavoriteCars) { car in
                                        CarCardView(car: car) {
                                            if let index = cars.firstIndex(where: { $0.id == car.id }) {
                                                cars[index].isFavorite.toggle()
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    // Add spacing at the bottom
                                    Spacer()
                                        .frame(height: 16)
                                }
                            }
                        }
                    }
                    .opacity(selectedTab == .favorites ? 1 : 0)
                    .animation(.none, value: selectedTab)
                    
                    // Profile tab
                    ProfileView()
                        .opacity(selectedTab == .profile ? 1 : 0)
                        .animation(.none, value: selectedTab)
                }
                
                // Custom Tab Bar (stays fixed)
                CustomTabBar(selectedTab: $selectedTab)
            }
            // Remove the default NavigationView title since we have our own
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    var tabTitle: String {
        switch selectedTab {
        case .home:
            return "Car Marketplace"
        case .favorites:
            return "My Favorites"
        case .profile:
            return "My Profile"
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search makes, models...", text: $text)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CarCardView: View {
    let car: Car
    let onFavoriteTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Car Image
            ZStack(alignment: .topTrailing) {
                Image(car.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                
                // Fallback for missing images in sample
                Color.gray.opacity(0.1)
                    .frame(height: 180)
                    .cornerRadius(12)
                
                // Favorite button
                Button(action: onFavoriteTapped) {
                    Image(systemName: car.isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                        .padding(8)
                        .foregroundColor(car.isFavorite ? .red : .white)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.8))
                                .shadow(radius: 2)
                        )
                }
                .padding(8)
            }
            
            // Car Details
            VStack(alignment: .leading, spacing: 4) {
                Text("\(car.year) \(car.make) \(car.model)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Text("$\(Int(car.price))")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("\(car.mileage) mi")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Quick Info Pills
                HStack(spacing: 8) {
                    InfoPill(icon: "fuelpump.fill", text: "Gas")
                    InfoPill(icon: "gear", text: "Auto")
                    InfoPill(icon: "person.2.fill", text: "5 seats")
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 4)
        }
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct InfoPill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
            
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: HomeView.Tab
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(icon: "car.fill", text: "Home", isSelected: selectedTab == .home) {
                selectedTab = .home
            }
            
            TabBarButton(icon: "heart.fill", text: "Favorites", isSelected: selectedTab == .favorites) {
                selectedTab = .favorites
            }
            
            TabBarButton(icon: "person.fill", text: "Profile", isSelected: selectedTab == .profile) {
                selectedTab = .profile
            }
        }
        .frame(height: 60)
        .background(
            Color.white
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -5)
        )
    }
}

struct TabBarButton: View {
    let icon: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                
                Text(text)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? .blue : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 24) {
            // Profile Header
            VStack(spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("John Doe")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Premium Member")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            // Profile Menu Items
            VStack(spacing: 0) {
                ProfileMenuItem(icon: "car.fill", title: "My Cars")
                ProfileMenuItem(icon: "bell.fill", title: "Notifications")
                ProfileMenuItem(icon: "creditcard.fill", title: "Payment Methods")
                ProfileMenuItem(icon: "gear", title: "Settings")
                ProfileMenuItem(icon: "questionmark.circle.fill", title: "Help & Support")
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            
            Spacer()
            
            // Sign Out Button
            Button(action: {}) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        
        Divider()
            .padding(.leading, 60)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

#Preview {
    HomeView()
}
