//
//  SignUpView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct SignUpView: View {
    var navigateToLogin: () -> Void
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var acceptTerms = false
    @State private var isLoading = false
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // For animation
    @State private var formOpacity: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                    .padding(.top, 50)
                
                // Signup form
                VStack(spacing: 20) {
                    // Full Name field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Full Name")
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                        
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white.opacity(0.5))
                            
                            TextField("", text: $fullName)
                                .foregroundColor(.white)
                                .autocapitalization(.words)
                                .placeholder(when: fullName.isEmpty) {
                                    Text("Enter your full name").foregroundColor(.white.opacity(0.5))
                                }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                    
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
                            
                            if showPassword {
                                TextField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Create a password").foregroundColor(.white.opacity(0.5))
                                    }
                            } else {
                                SecureField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Create a password").foregroundColor(.white.opacity(0.5))
                                    }
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                    
                    // Confirm Password field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm Password")
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.white.opacity(0.5))
                            
                            if showConfirmPassword {
                                TextField("", text: $confirmPassword)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: confirmPassword.isEmpty) {
                                        Text("Confirm your password").foregroundColor(.white.opacity(0.5))
                                    }
                            } else {
                                SecureField("", text: $confirmPassword)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: confirmPassword.isEmpty) {
                                        Text("Confirm your password").foregroundColor(.white.opacity(0.5))
                                    }
                            }
                            
                            Button(action: {
                                showConfirmPassword.toggle()
                            }) {
                                Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.1))
                        )
                    }
                    
                    // Terms and conditions
                    HStack(alignment: .top) {
                        Toggle(isOn: $acceptTerms) {
                            Text("I agree to the ")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8)) +
                            Text("Terms of Service")
                                .font(.subheadline)
                                .foregroundColor(.white) +
                            Text(" and ")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8)) +
                            Text("Privacy Policy")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                    }
                    .padding(.top, 10)
                    
                    // Sign up button
                    Button(action: {
                        withAnimation {
                            isLoading = true
                        }
                        // Validate form
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            if fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                                alertMessage = "Please fill in all fields"
                                showAlert = true
                            } else if password != confirmPassword {
                                alertMessage = "Passwords do not match"
                                showAlert = true
                            } else if !acceptTerms {
                                alertMessage = "Please accept the terms and conditions"
                                showAlert = true
                            } else {
                                // Handle successful signup
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(#colorLiteral(red: 0.9764705896, green: 0.8039215803, blue: 0.1843137443, alpha: 1)))
                            
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))))
                                    .scaleEffect(1.5)
                            } else {
                                Text("Create Account")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    .padding()
                            }
                        }
                        .frame(height: 55)
                    }
                    .disabled(isLoading)
                    
                    // Social signup options
                    VStack(spacing: 15) {
                        Text("Or sign up with")
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 20) {
                            SocialLoginButton(image: "apple.logo", color: .white)
                            SocialLoginButton(image: "g.circle.fill", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                            SocialLoginButton(image: "f.circle.fill", color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        }
                    }
                    
                    // Login link
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.white.opacity(0.7))
                        
                        Button(action: {
                            navigateToLogin()
                        }) {
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
                .opacity(formOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        formOpacity = 1
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
