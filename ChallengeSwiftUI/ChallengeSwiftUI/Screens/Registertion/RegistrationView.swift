import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel: RegistrationViewModel
    @State private var registrationComplete: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Sing-Up")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
            
            TextFieldView(title: "First Name", text: $viewModel.firstName)
            TextFieldView(title: "Last Name", text: $viewModel.lastName)
            TextFieldView(title: "Username", text: $viewModel.username)
            PasswordFieldView(title: "Password", password: $viewModel.password)
            AuthButton(buttonText: "Sing-Up", action: register)

            
        NavigationLink(destination: CategoryList(),isActive: $registrationComplete){
                EmptyView()
            }
        }
        .padding()
        .alert(isPresented: Binding<Bool>.constant(!errorMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                errorMessage = ""
            }))
        }
    }
    
    private func register() {
            Task {
                do {
                    try await viewModel.registerUser()
                    registrationComplete = true
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RegistrationViewModel()
        RegistrationView(viewModel: viewModel)
    }
}
