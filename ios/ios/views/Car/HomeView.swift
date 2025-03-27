//
//  HomeView.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CarViewModel()
    @State private var searchText: String = ""
    var isFirstLogin: Bool = false

    var filteredCars: [Car] {
        if searchText.isEmpty {
            return viewModel.cars
        } else {
            return viewModel.cars.filter { car in
                car.name.lowercased().contains(searchText.lowercased())
            }
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

                TextField("Finding car...", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

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
                            if filteredCars.isEmpty {
                                Text("No cars match your search.")
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(filteredCars) { car in
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
            .navigationBarBackButtonHidden(true)
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
