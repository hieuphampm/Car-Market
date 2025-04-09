//
//  SignUpView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    var navigateToLogin: () -> Void
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var acceptTerms = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            // Background Gradient - Matching LoginView
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Back Button
                    HStack {
                        Button(action: {
                            navigateToLogin()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.leading)
                    
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 20) {
                        CustomTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .foregroundColor(.white.opacity(0.8))
                                .fontWeight(.medium)
                            
                            CustomSecureField(icon: "lock.fill", placeholder: "Enter your password", text: $password)
                        }
                        
                        // Firebase Sign-Up Button
                        Button(action: signUp) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.yellow)
                                
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                        .scaleEffect(1.5)
                                } else {
                                    Text("Create Account")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                            .frame(height: 55)
                        }
                        .disabled(isLoading)

                        // Login link
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.white.opacity(0.7))
                            
                            Button(action: navigateToLogin) {
                                Text("Log In")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 40)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.black.opacity(0.2))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                }
                .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // Firebase Sign-Up Function
    func signUp() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            isLoading = false
            alertMessage = error?.localizedDescription ?? "Account Created Successfully!"
            showAlert = true
        }
    }
}
