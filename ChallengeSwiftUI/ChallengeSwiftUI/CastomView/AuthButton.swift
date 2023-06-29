import SwiftUI
struct AuthButton: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(10)
                .background(
                    RoundedRectangle(
                        cornerRadius: 20,
                        style: .continuous
                    )
                    .stroke(.blue, lineWidth: 2)
                )
        }
    }
}



