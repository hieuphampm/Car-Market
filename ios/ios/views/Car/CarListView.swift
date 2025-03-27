//
//  CarListView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//
import SwiftUI

struct CarListView: View {
    @StateObject private var viewModel = CarViewModel()
    @State private var searchText: String = ""
    @State private var selectedManufacturer: String = "All"
    let manufacturers = ["All", "Toyota", "Ford", "BMW", "Tesla", "Porsche"]

    var filteredCars: [Car] {
        viewModel.cars.filter { car in
            (selectedManufacturer == "All" || car.name.contains(selectedManufacturer)) &&
            (searchText.isEmpty || car.name.lowercased().contains(searchText.lowercased()))
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading cars...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
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
                            CarCardView(car: car)
                        }
                    }
                }
            }
            .navigationTitle("Car List")
            .onAppear {
                viewModel.fetchCars()
            }
        }
    }
}

#Preview {
    CarListView()
}
