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
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            HomeView(isFirstLogin: true)
        } else {
            loginContent
        }
    }
    
    var loginContent: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

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
                        CustomTextField(icon: "envelope.fill", placeholder: "Enter your email", text: $email)
                        CustomSecureField(icon: "lock.fill", placeholder: "Enter your password", text: $password)

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
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Firebase Email/Password Login
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                isLoggedIn = true
            }
        }
    }

    // Google Sign-In using Firebase
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            alertMessage = "Google Sign-In Configuration Error"
            showAlert = true
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
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
                    showAlert = true
                } else {
                    isLoggedIn = true
                }
            }
        }
    }
}

// Custom Input Fields
struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .foregroundColor(.white.opacity(0.8))
                .fontWeight(.medium)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.5))
                
                TextField("", text: $text)
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
    }
}

struct CustomSecureField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .foregroundColor(.white.opacity(0.8))
                .fontWeight(.medium)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.5))
                
                SecureField("", text: $text)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
        }
    }
}
