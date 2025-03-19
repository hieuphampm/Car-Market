//
//  ProfileView.swift
//  ios
//
//  Created by umtlab03im13 on 19/3/25.
//


import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 24) {
            // Profile Header
            VStack(spacing: 12) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("John Doe")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Premium Member")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            // Profile Menu Items
            VStack(spacing: 0) {
                ProfileMenuItem(icon: "car.fill", title: "My Cars")
                ProfileMenuItem(icon: "bell.fill", title: "Notifications")
                ProfileMenuItem(icon: "creditcard.fill", title: "Payment Methods")
                ProfileMenuItem(icon: "gear", title: "Settings")
                ProfileMenuItem(icon: "questionmark.circle.fill", title: "Help & Support")
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            
            Spacer()
            
            // Sign Out Button
            Button(action: {}) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        
        Divider()
            .padding(.leading, 60)
    }
}
