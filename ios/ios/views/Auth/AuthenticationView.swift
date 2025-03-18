 //
//  AuthenticationView.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

struct AuthenticationView: View {
    @State private var currentScreen: AuthScreen = .login
    
    enum AuthScreen {
        case login
        case signup
        case forgotPassword
    }
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            // Content
            switch currentScreen {
            case .login:
                LoginView(
                    navigateToSignUp: { currentScreen = .signup },
                    navigateToForgotPassword: { currentScreen = .forgotPassword }
                )
            case .signup:
                SignUpView(
                    navigateToLogin: { currentScreen = .login }
                )
            case .forgotPassword:
                ForgotPasswordView(
                    navigateToLogin: { currentScreen = .login }
                )
            }
        }
    }
}

// Preview
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}

#Preview {
    AuthenticationView()
}
