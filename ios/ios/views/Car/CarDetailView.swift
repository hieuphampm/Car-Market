//
//  CarDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//
import SwiftUI

struct CarDetailView: View {
    let car: Car
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            // Main Scroll Content
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Car Image
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
                    
                    // Car Details
                    VStack(alignment: .leading, spacing: 10) {
                        Text(car.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Price: $\(car.price, specifier: "%.2f")")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                        
                        // Detailed Specs
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                DetailRow(icon: "calendar", text: "Year: \(car.year)")
                                DetailRow(icon: "chevron.left.forwardslash.chevron.right", text: "Engine: \(car.engine)")
                                DetailRow(icon: "gauge", text: "Mileage: \(car.mileage) km")
                                DetailRow(icon: "gear", text: "Transmission: \(car.transmission)")
                            }
                        }
                        
                        // Utilities Section
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
                        
                        // Add padding to bottom to ensure content isn't hidden behind action bar
                        Spacer()
                            .frame(height: 100)
                    }
                    .padding()
                }
            }
            
            // Permanent Action Bar
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    // Buy Button
                    Button(action: {
                        // Implement buy action
                        print("Buying \(car.name)")
                    }) {
                        Text("Buy Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    // Favorite Button
                    Button(action: {
                        isFavorite.toggle()
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
        }
    }
}

// Helper View for Detail Rows
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
