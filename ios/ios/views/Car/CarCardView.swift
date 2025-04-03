//
//  CarCardView.swift
//  ios
//
//  Created by umtlab03im13 on 19/3/25.
//
import SwiftUI

struct CarCardView: View {
    let car: Car

    var body: some View {
        VStack(alignment: .leading) {
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
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                @unknown default:
                    ProgressView()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                }
            }

            Text(car.name)
                .font(.headline)
                .foregroundColor(.black)

            Text("$\(car.price, specifier: "%.f")")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width - 10)
        .frame(maxHeight: UIScreen.main.bounds.height * 0.7)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


#Preview {
    CarCardView(car: Car(id: "car_01", name: "Porsche 911 GT3 Touring", price: 189000, engine: "4.0L Flat-6", year: 2022, transmission: "Manual (6-Speed)", utilities: ["Performance-Oriented Driving"], mileage: 4600, imageURL: "https://via.placeholder.com/150"))
}
