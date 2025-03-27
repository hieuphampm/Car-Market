//
//  CarViewModel.swift
//  ios
//
//  Created by umtlab03im13 on 25/3/25.
//

import Foundation
import FirebaseDatabase

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var dbRef: DatabaseReference!

    init() {
        dbRef = Database.database().reference(withPath: "cars")
    }

    func fetchCars() {
        print("🔥 Starting to fetch cars from Realtime Database...")
        isLoading = true
        errorMessage = nil

        dbRef.observe(.value) { snapshot in
            defer { self.isLoading = false }

            guard snapshot.exists(), let value = snapshot.value as? [String: Any] else {
                print("🔥 No data found in 'cars' node")
                self.errorMessage = "No cars found in the database"
                return
            }

            var fetchedCars: [Car] = []
            for (key, carData) in value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: carData, options: [])
                    let car = try JSONDecoder().decode(Car.self, from: jsonData)
                    // No need to set car.id = key since the JSON already contains the "id" field
                    fetchedCars.append(car)
                    print("🔥 Successfully decoded car with key \(key): \(car)")
                } catch {
                    print("🔥 Error decoding car with key \(key): \(error)")
                    self.errorMessage = "Error decoding car data: \(error.localizedDescription)"
                }
            }

            print("🔥 Fetched \(fetchedCars.count) cars: \(fetchedCars)")
            DispatchQueue.main.async {
                self.cars = fetchedCars
            }
        } withCancel: { error in
            print("🔥 Realtime Database observation cancelled: \(error)")
            self.errorMessage = "Observation cancelled: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
