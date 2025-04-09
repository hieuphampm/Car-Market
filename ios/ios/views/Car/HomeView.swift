//
//  HomeView.swift
//  ios
//
//  Created by umtlab03im13 on 25/3/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CarViewModel()
    @State private var searchText: String = ""
    @State private var sortOption: SortOption = .none
    var isFirstLogin: Bool = false
    
    // Enum to handle different sorting options
    enum SortOption {
        case none
        case nameAscending
        case priceAscending
        case priceDescending
        case mileageAscending
        case mileageDescending
        
        var displayText: String {
            switch self {
            case .none: return "Default"
            case .nameAscending: return "Name (A-Z)"
            case .priceAscending: return "Price (Low to High)"
            case .priceDescending: return "Price (High to Low)"
            case .mileageAscending: return "Mileage (Low to High)"
            case .mileageDescending: return "Mileage (High to Low)"
            }
        }
    }

    var sortedAndFilteredCars: [Car] {
        let filtered = searchText.isEmpty ? viewModel.cars : viewModel.cars.filter { car in
            car.name.lowercased().contains(searchText.lowercased())
        }
        
        switch sortOption {
        case .none:
            return filtered
        case .nameAscending:
            return filtered.sorted { $0.name < $1.name }
        case .priceAscending:
            return filtered.sorted { $0.price < $1.price }
        case .priceDescending:
            return filtered.sorted { $0.price > $1.price }
        case .mileageAscending:
            return filtered.sorted { $0.mileage < $1.mileage }
        case .mileageDescending:
            return filtered.sorted { $0.mileage > $1.mileage }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Updated Profile Navigation Button positioning
                HStack {
                    Text("Car Market")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // Search and Sort Bar
                VStack(spacing: 12) {
                    TextField("Finding car...", text: $searchText)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        Text("Sort by:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Picker("Sort by", selection: $sortOption) {
                            Text("Default").tag(SortOption.none)
                            Text("Name (A-Z)").tag(SortOption.nameAscending)
                            Text("Price ↑").tag(SortOption.priceAscending)
                            Text("Price ↓").tag(SortOption.priceDescending)
                            Text("Mileage ↑").tag(SortOption.mileageAscending)
                            Text("Mileage ↓").tag(SortOption.mileageDescending)
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Spacer()
                        
                        // Selected sort option display
                        if sortOption != .none {
                            HStack(spacing: 4) {
                                Text(sortOption.displayText)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    sortOption = .none
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.caption)
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }

                if viewModel.isLoading {
                    ProgressView("Loading cars...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if sortedAndFilteredCars.isEmpty {
                                Text("No cars match your search.")
                                    .foregroundColor(.gray)
                                    .padding(.top, 40)
                            } else {
                                // Results counter
                                HStack {
                                    Text("\(sortedAndFilteredCars.count) cars found")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                ForEach(sortedAndFilteredCars) { car in
                                    NavigationLink(destination: CarDetailView(car: car)) {
                                        CarCardView(car: car)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                print("HomeView appeared, fetching cars...")
                viewModel.fetchCars()
                
                if isFirstLogin {
                    print("First login detected")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomeView()
}
