struct CustomTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .foregroundColor(.white)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
        .padding(.horizontal)
    }
}
