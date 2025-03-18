//
//  CarListView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct CarListView: View {
    @State private var searchText: String = ""
    @State private var selectedManufacturer: String = "All"
    let manufacturers = ["All", "Toyota", "Ford", "BMW", "Tesla"]
    
    @State private var cars: [Car] = [
        Car(make: "Toyota", model: "Camry", year: 2023, price: 28500, mileage: 5, imageURL: "car1"),
        Car(make: "Honda", model: "Accord", year: 2022, price: 27800, mileage: 12000, imageURL: "car2"),
        Car(make: "Ford", model: "Mustang", year: 2023, price: 42000, mileage: 3000, imageURL: "car3")
    ]
    
    var filteredCars: [Car] {
        cars.filter { car in
            (selectedManufacturer == "All" || car.make == selectedManufacturer) &&
            (searchText.isEmpty || car.model.lowercased().contains(searchText.lowercased()))
        }
    }
    
    var body: some View {
        VStack {
            // Bộ lọc
            HStack {
                Picker("Manufacturer", selection: $selectedManufacturer) {
                    ForEach(manufacturers, id: \.self) { manufacturer in
                        Text(manufacturer)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                TextField("Search by model...", text: $searchText)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            List(filteredCars) { car in
                NavigationLink(destination: CarDetailView(car: car)) {
                    CarCardView(car: car, onFavoriteTapped: {})
                }
            }
        }
        .navigationTitle("Car List")
    }
}


#Preview {
    CarListView()
}
