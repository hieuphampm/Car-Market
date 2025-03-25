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
        ScrollView {
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white.opacity(0.5))
                            
                            TextField("", text: $email)
                                .foregroundColor(.white)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                        
                        SecureField("", text: $password)
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.1))
                            )
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
            }
            .padding()
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
