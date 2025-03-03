import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom, 20)
                
                CustomTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                CustomSecureField(icon: "lock.fill", placeholder: "Mật khẩu", text: $password)
                CustomSecureField(icon: "lock.fill", placeholder: "Xác nhận mật khẩu", text: $confirmPassword)
                
                GradientButton(title: "Đăng ký") {
                    print("Đăng ký tài khoản...")
                }
                
                HStack {
                    Text("Đã có tài khoản?")
                        .foregroundColor(.white)
                    NavigationLink(destination: LoginView()) {
                        Text("Đăng nhập ngay")
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                    }
                }
            }
            .padding()
        }
    }
}
