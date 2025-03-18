//
//  CarDetailView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct CarDetailView: View {
    let car: Car
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Ảnh xe
                Image(car.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .shadow(radius: 4)

                Text("\(car.year) \(car.make) \(car.model)")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Price: $\(car.price, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.blue)

                Text("Mileage: \(car.mileage) mi")
                    .font(.subheadline)

                Button(action: {
                    // Thêm vào danh sách yêu thích
                }) {
                    Text("Add to Favorites")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Car Details")
    }
}

