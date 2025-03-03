struct CustomSecureField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = true

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
        .padding(.horizontal)
    }
}
