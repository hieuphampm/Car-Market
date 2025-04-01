//
//  CarDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//
import SwiftUI

struct CarDetailView: View {
    let car: Car
    @State private var showCustomerDetail: Bool = false
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    // Changed to compute isFavorite instead of using @State
    private var isFavorite: Bool {
        favoritesManager.isFavorite(car)
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: car.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .foregroundColor(.gray)
                                .cornerRadius(15)
                        @unknown default:
                            ProgressView()
                                .frame(height: 250)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(car.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Price: $\(car.price, specifier: "%.2f")")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                DetailRow(icon: "calendar", text: "Year: \(car.year)")
                                DetailRow(icon: "chevron.left.forwardslash.chevron.right", text: "Engine: \(car.engine)")
                                DetailRow(icon: "gauge", text: "Mileage: \(car.mileage) km")
                                DetailRow(icon: "gear", text: "Transmission: \(car.transmission)")
                            }
                        }
                        
                        if !car.utilities.isEmpty {
                            Text("Utilities:")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            ForEach(car.utilities, id: \.self) { utility in
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                    Text(utility)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 100)
                    }
                    .padding()
                }
            }
            
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    Button(action: {
                        showCustomerDetail = true
                        print("Buy Now clicked, navigating to CustomerDetailView")
                    }) {
                        Text("Buy Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        favoritesManager.toggleFavorite(car)
                        // No need to toggle state as we're now using a computed property
                        print(isFavorite ? "Added to Favorites" : "Removed from Favorites")
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .edgesIgnoringSafeArea(.bottom)
            
            NavigationLink(destination: CustomerDetailView(car: car), isActive: $showCustomerDetail) {
                EmptyView()
            }
        }
        .navigationTitle("Car Details")
        .onAppear {
            NotificationCenter.default.addObserver(
                forName: Notification.Name("DismissToHomeView"),
                object: nil,
                queue: .main
            ) { _ in
                presentationMode.wrappedValue.dismiss()
            }
        }
        .onDisappear {
            NotificationCenter.default.removeObserver(
                self,
                name: Notification.Name("DismissToHomeView"),
                object: nil
            )
        }
    }
}

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            Text(text)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationView {
        CarDetailView(car: Car(id: "car_01",
                               name: "Porsche 911 GT3 Touring",
                               price: 189000,
                               engine: "4.0L Flat-6",
                               year: 2022,
                               transmission: "Manual (6-Speed)",
                               utilities: ["Performance-Oriented Driving", "Ceramic Brakes"],
                               mileage: 4600,
                               imageURL: "https://via.placeholder.com/250"))
    }
}
