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
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: car.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 250)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .cornerRadius(10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                    @unknown default:
                        ProgressView()
                            .frame(height: 250)
                    }
                }

                Text(car.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Giá: $\(car.price, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.blue)

                Text("Năm sản xuất: \(car.year)")
                    .font(.headline)

                Text("Động cơ: \(car.engine)")
                    .font(.headline)

                Text("Số km: \(car.mileage) km")
                    .font(.headline)

                Text("Hộp số: \(car.transmission)")
                    .font(.headline)

                Text("Tiện ích:")
                    .font(.headline)

                ForEach(car.utilities, id: \.self) { utility in
                    Text("- \(utility)")
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(car.name)
        .onAppear {
            print("🔥 Showing details for car: \(car.name)")
        }
    }
}

#Preview {
    CarDetailView(car: Car(id: "car_01", name: "Porsche 911 GT3 Touring", price: 189000, engine: "4.0L Flat-6", year: 2022, transmission: "Manual (6-Speed)", utilities: ["Performance-Oriented Driving"], mileage: 4600, imageURL: "https://via.placeholder.com/250"))
}
