import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Logo
                Image("app_logo") // Thay bằng tên logo trong Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                
                // Email Input
                CustomTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                
                // Password Input
                CustomSecureField(icon: "lock.fill", placeholder: "Mật khẩu", text: $password, isSecure: !$isPasswordVisible)
                
                // Toggle hiển thị mật khẩu
                Toggle("Hiển thị mật khẩu", isOn: $isPasswordVisible)
                    .toggleStyle(SwitchToggleStyle(tint: .white))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                // Button Đăng nhập
                GradientButton(title: "Đăng nhập") {
                    print("Đăng nhập...")
                }
                
                // Điều hướng sang Đăng ký
                HStack {
                    Text("Chưa có tài khoản?")
                        .foregroundColor(.white)
                    NavigationLink(destination: RegisterView()) {
                        Text("Đăng ký ngay")
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding()
        }
    }
}
