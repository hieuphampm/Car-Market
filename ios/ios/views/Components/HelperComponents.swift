//
//  HelperComponents.swift
//  ios
//
//  Created by umtlab03im13 on 18/3/25.
//

import SwiftUI

// Social login button component
struct SocialLoginButton: View {
    let image: String
    let color: Color
    
    var body: some View {
        Button(action: {
            // Handle social login
        }) {
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.1))
                )
        }
    }
}

// Custom checkbox toggle style
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(configuration.isOn ? Color(#colorLiteral(red: 0.9764705896, green: 0.8039215803, blue: 0.1843137443, alpha: 1)) : Color.white.opacity(0.2))
                    .frame(width: 20, height: 20)
                
                if configuration.isOn {
                    Image(systemName: "checkmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
            
            configuration.label
        }
    }
}

// Extension for placeholder text
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
