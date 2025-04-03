//
//  ProfileView.swift
//  ios
//
// Created by umtlab03im13 on 28/3/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToAuth = false
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    @State private var userName: String = "Demo"
    @State private var isEditingName: Bool = false
    @State private var tempName: String = "Demo"
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Header
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 100, height: 100)
                                .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            Text(userName.prefix(1))
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 4) {
                            if isEditingName {
                                HStack {
                                    TextField("Your Name", text: $tempName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 8)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                                            }
                                        }
                                }
                                .frame(width: 200)
                                
                                HStack(spacing: 20) {
                                    Button("Cancel") {
                                        isEditingName = false
                                        tempName = userName
                                    }
                                    .foregroundColor(.red)
                                    
                                    Button("Save") {
                                        if !tempName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                            userName = tempName.trimmingCharacters(in: .whitespacesAndNewlines)
                                            saveUserName()
                                            isEditingName = false
                                        }
                                    }
                                    .foregroundColor(.blue)
                                    .disabled(tempName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                                }
                                .padding(.top, 8)
                            } else {
                                HStack {
                                    Text(userName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    
                                    Button(action: {
                                        tempName = userName
                                        isEditingName = true
                                    }) {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.blue)
                                            .font(.system(size: 18))
                                    }
                                }
                            }
                            
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                
                                Text("Premium Member")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(20)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Account Section
                    SectionCard(title: "Account") {
                        NavigationLink(destination: MyCarsView()) {
                            ProfileMenuItem(
                                icon: "car.fill",
                                iconColor: .blue,
                                title: "My Cars",
                                badgeCount: favoritesManager.favoriteCars.count
                            )
                        }
                        
                        ProfileMenuItem(
                            icon: "creditcard.fill",
                            iconColor: .green,
                            title: "Payment Methods"
                        )
                    }
                    
                    // Preferences Section
                    SectionCard(title: "Preferences") {
                        ProfileMenuItem(
                            icon: "gear",
                            iconColor: .gray,
                            title: "Settings"
                        )
                        
                        ProfileMenuItem(
                            icon: "questionmark.circle.fill",
                            iconColor: .purple,
                            title: "Help & Support"
                        )
                        
                        ProfileMenuItem(
                            icon: "doc.text.fill",
                            iconColor: .indigo,
                            title: "Terms & Privacy"
                        )
                    }
                    
                    // Sign Out Button
                    Button(action: signOut) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red, lineWidth: 1.5)
                                .background(Color.red.opacity(0.05).cornerRadius(16))
                        )
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // Commented out toolbar button
                // Button(action: {
                // }) {
                //     Image(systemName: "pencil")
                //         .foregroundColor(.blue)
                // }
            }
        }
        .fullScreenCover(isPresented: $navigateToAuth) {
            AuthenticationView()
        }
        .onAppear {
            loadUserName()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            navigateToAuth = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func saveUserName() {
        UserDefaults.standard.set(userName, forKey: "userName")
        print("Saved user name: \(userName)")
    }
    
    func loadUserName() {
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            userName = savedName
            tempName = savedName
            print("Loaded user name: \(userName)")
        }
    }
}

// Supporting view structures
struct SectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.leading, 8)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
        }
    }
}

struct ProfileMenuItem: View {
    let icon: String
    var iconColor: Color
    let title: String
    var badgeCount: Int? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.black) // Changed text color to black
            
            Spacer()
            
            if let count = badgeCount, count > 0 {
                Text("\(count)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        
        if title != "Help & Support" && title != "Terms & Privacy" && title != "Payment Methods" {
            Divider()
                .padding(.leading, 68)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
