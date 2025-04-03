//
//  MyCarsView.swift
//  ios
//
//  Created on 1/4/25.
//

import SwiftUI

struct MyCarsView: View {
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        VStack {
            // Cars List Content
            if favoritesManager.favoriteCars.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    
                    Text("No Favorite Cars")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Cars you add to favorites will appear here")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(favoritesManager.favoriteCars) { car in
                            NavigationLink(destination: CarDetailView(car: car)) {
                                FavoriteCarRow(car: car, favoritesManager: favoritesManager)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("My Cars")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Sort by Name") {
                        sortByName()
                    }
                    Button("Sort by Price") {
                        sortByPrice()
                    }
                    Button("Sort by Year") {
                        sortByYear()
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func sortByName() {
        withAnimation {
            favoritesManager.favoriteCars.sort { $0.name < $1.name }
        }
    }
    
    private func sortByPrice() {
        withAnimation {
            favoritesManager.favoriteCars.sort { $0.price < $1.price }
        }
    }
    
    private func sortByYear() {
        withAnimation {
            favoritesManager.favoriteCars.sort { $0.year > $1.year }
        }
    }
}

struct FavoriteCarRow: View {
    let car: Car
    let favoritesManager: FavoritesManager
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: car.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                @unknown default:
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(car.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("$\(car.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Text("\(car.year) • \(car.engine)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    favoritesManager.removeFavorite(car)
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(8)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        MyCarsView()
    }
}
