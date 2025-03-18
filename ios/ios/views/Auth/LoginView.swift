//
//  LoginView.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI

struct LoginView: View {
    var navigateToSignUp: () -> Void
    var navigateToForgotPassword: () -> Void
    
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var isLoading = false
    @State private var showPassword = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // For animation
    @State private var logoOffset: CGFloat = -100
    @State private var formOpacity: Double = 0
    
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
                    .offset(y: logoOffset)
                    .onAppear {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            logoOffset = 0
                        }
                        
                        withAnimation(.easeInOut(duration: 0.7).delay(0.3)) {
                            formOpacity = 1
                        }
                    }
                
                Text("Car Market")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                    .offset(y: logoOffset)
                
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
                            
                            if showPassword {
                                TextField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white.opacity(0.5))
                                    }
                            } else {
                                SecureField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white.opacity(0.5))
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
                    
                    // Remember me & Forgot password
                    HStack {
                        Toggle(isOn: $rememberMe) {
                            Text("Remember me")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        
                        Spacer()
                        
                        Button(action: {
                            navigateToForgotPassword()
                        }) {
                            Text("Forgot Password?")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    
                    // Login button
                    Button(action: {
                        withAnimation {
                            isLoading = true
                        }
                        // Simulate login process
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            if email.isEmpty || password.isEmpty {
                                alertMessage = "Please enter both email and password"
                                showAlert = true
                            } else {
                                // Handle successful login
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
                                Text("Log In")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    .padding()
                            }
                        }
                        .frame(height: 55)
                    }
                    .disabled(isLoading)
                    
                    // Social login options
                    VStack(spacing: 15) {
                        Text("Or continue with")
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 20) {
                            SocialLoginButton(image: "apple.logo", color: .white)
                            SocialLoginButton(image: "g.circle.fill", color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                            SocialLoginButton(image: "f.circle.fill", color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
                        }
                    }
                    
                    // Sign up button
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.7))
                        
                        Button(action: {
                            navigateToSignUp()
                        }) {
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
                .opacity(formOpacity)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
