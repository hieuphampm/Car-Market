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
           LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
               .ignoresSafeArea()
           
           switch currentScreen {
           case .login:
               LoginView(navigateToSignUp: { currentScreen = .signup },
                         navigateToForgotPassword: { currentScreen = .forgotPassword })
           case .signup:
               SignUpView(navigateToLogin: { currentScreen = .login })
           case .forgotPassword:
               ForgotPasswordView(navigateToLogin: { currentScreen = .login })
           }
       }
   }
}

struct AuthenticationView_Previews: PreviewProvider {
   static var previews: some View {
       AuthenticationView()
   }
}
