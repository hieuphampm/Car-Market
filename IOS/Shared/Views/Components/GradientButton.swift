struct GradientButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.horizontal)
        }
    }
}
