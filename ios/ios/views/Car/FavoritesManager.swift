//
//  FavoritesManager.swift
//  ios
//
//  Created on 1/4/25.
//

import Foundation
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favoriteCars: [Car] = []
    
    private let favoritesKey = "favoriteCars"
    
    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                let decoder = JSONDecoder()
                self.favoriteCars = try decoder.decode([Car].self, from: data)
                print("Loaded \(favoriteCars.count) favorite cars")
            } catch {
                print("Error decoding favorite cars: \(error)")
            }
        }
    }
    
    func saveFavorites() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favoriteCars)
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("Saved \(favoriteCars.count) favorite cars")
        } catch {
            print("Error encoding favorite cars: \(error)")
        }
    }
    
    func addFavorite(_ car: Car) {
        // Check if car is already in favorites to avoid duplicates
        if !isFavorite(car) {
            favoriteCars.append(car)
            saveFavorites()
        }
    }
    
    func removeFavorite(_ car: Car) {
        favoriteCars.removeAll { $0.id == car.id }
        saveFavorites()
    }
    
    func isFavorite(_ car: Car) -> Bool {
        return favoriteCars.contains { $0.id == car.id }
    }
    
    func toggleFavorite(_ car: Car) {
        if isFavorite(car) {
            removeFavorite(car)
        } else {
            addFavorite(car)
        }
    }
}

// Create a singleton for easy access throughout the app
extension FavoritesManager {
    static let shared = FavoritesManager()
}
