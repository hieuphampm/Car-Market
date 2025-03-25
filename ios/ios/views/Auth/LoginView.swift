//
//  LoginView.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

struct LoginView: View {
    var navigateToSignUp: () -> Void
    var navigateToForgotPassword: () -> Void
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Logo
                Spacer()
                    .frame(height: 30)
                Image(systemName: "car.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 150, height: 150)
                    )
                
                Text("Car Market")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)

                // Login form
                VStack(spacing: 20) {
                    // Email field
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
                                .placeholder(when: email.isEmpty) {
                                    Text("Enter your email").foregroundColor(.white.opacity(0.5))
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                    
                    // Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white.opacity(0.5))
                            
                            SecureField("", text: $password)
                                .foregroundColor(.white)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .placeholder(when: password.isEmpty) {
                                    Text("Enter your password").foregroundColor(.white.opacity(0.5))
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                    
                    // Login button
                    Button(action: login) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.yellow)
                            
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                    .scaleEffect(1.5)
                            } else {
                                Text("Log In")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        }
                        .frame(height: 55)
                    }
                    .disabled(isLoading)

                    // Forgot password
                    Button(action: navigateToForgotPassword) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }

                    // Google Sign-In button
                    Button(action: signInWithGoogle) {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .foregroundColor(.red)
                            Text("Continue with Google")
                                .fontWeight(.bold)
                        }
                    }
                    .padding()

                    // Sign up button
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.7))
                        
                        Button(action: navigateToSignUp) {
                            Text("Sign Up")
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Firebase Email/Password Login
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                alertMessage = error.localizedDescription
            } else {
                alertMessage = "Login successful!"
            }
            showAlert = true
        }
    }

    // Google Sign-In using Firebase
    func signInWithGoogle() {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let clientID = plist["CLIENT_ID"] as? String else {
            alertMessage = "Failed to retrieve GIDClientID from GoogleService-Info.plist"
            showAlert = true
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        guard let rootViewController = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                alertMessage = "Google Sign-In Error: \(error.localizedDescription)"
                showAlert = true
                return
            }

            guard let result = signInResult,
                  let idToken = result.user.idToken?.tokenString else {
                alertMessage = "Failed to retrieve Google ID Token."
                showAlert = true
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: result.user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    alertMessage = "Firebase Sign-In Error: \(error.localizedDescription)"
                } else {
                    alertMessage = "Google Sign-In Successful!"
                }
                showAlert = true
            }
        }
    }


}
