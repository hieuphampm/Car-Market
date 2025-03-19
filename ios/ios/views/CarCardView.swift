//
//  CarCardView.swift
//  ios
//
//  Created by umtlab03im13 on 19/3/25.
//

import SwiftUI

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
                Button(action: {
                    // Use onFavoriteTapped and prevent navigation propagation
                    onFavoriteTapped()
                }) {
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
                .buttonStyle(BorderlessButtonStyle()) // Prevents navigation tap from triggering
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
