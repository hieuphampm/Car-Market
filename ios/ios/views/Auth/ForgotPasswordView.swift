//
//  ForgotPasswordView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    var navigateToLogin: () -> Void
    
    @State private var email = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isSuccess = false
    
    // For animation
    @State private var formOpacity: Double = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with back button
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
            
            // Icon
            Image(systemName: "key.fill")
                .font(.system(size: 70))
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 130, height: 130)
                )
                .padding(.top, 20)
            
            // Title and description
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Text("Enter your email address below and we'll send you a link to reset your password.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.8))
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            // Form
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
                
                // Reset password button
                Button(action: {
                    withAnimation {
                        isLoading = true
                    }
                    // Validate and send reset link
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                        if email.isEmpty {
                            alertTitle = "Error"
                            alertMessage = "Please enter your email address"
                            isSuccess = false
                            showAlert = true
                        } else {
                            // Handle successful reset request
                            alertTitle = "Success"
                            alertMessage = "Password reset instructions have been sent to your email"
                            isSuccess = true
                            showAlert = true
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
                            Text("Send Reset Link")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                .padding()
                        }
                    }
                    .frame(height: 55)
                }
                .disabled(isLoading)
                
                // Login link
                HStack {
                    Text("Remember your password?")
                        .foregroundColor(.white.opacity(0.7))
                    
                    Button(action: {
                        navigateToLogin()
                    }) {
                        Text("Log In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)
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
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if isSuccess {
                        navigateToLogin()
                    }
                }
            )
        }
    }
}
