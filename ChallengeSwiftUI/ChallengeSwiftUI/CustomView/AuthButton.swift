import SwiftUI

struct AuthButton: View {
    var buttonText: String
    var action: () async throws -> Void
    
    @State private var isLoading = false
    
    var body: some View {
        Button(action: {
            isLoading = true
            Task {
                do {
                    try await action()
                    isLoading = false
                } catch {
                    isLoading = false
                    // Handle error
                }
            }
        }) {
            Group {
                if isLoading {
                    ProgressView()
                } else {
                    Text(buttonText.capitalized)
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.blue, lineWidth: 2)
            )
        }
        .disabled(isLoading)
    }
}

