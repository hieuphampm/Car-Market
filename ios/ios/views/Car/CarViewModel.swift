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
        isLoading = true
        errorMessage = nil
        dbRef.observe(.value) { snapshot in
            defer { self.isLoading = false }
            guard snapshot.exists(), let value = snapshot.value as? [String: Any] else {
                self.errorMessage = "No cars found in the database"
                return
            }
            var fetchedCars: [Car] = []
            for (key, carData) in value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: carData, options: [])
                    let car = try JSONDecoder().decode(Car.self, from: jsonData)
                    fetchedCars.append(car)
                } catch {
                    self.errorMessage = "Error decoding car data: \(error.localizedDescription)"
                }
            }
            DispatchQueue.main.async {
                self.cars = fetchedCars
            }
        } withCancel: { error in
            self.errorMessage = "Observation cancelled: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
