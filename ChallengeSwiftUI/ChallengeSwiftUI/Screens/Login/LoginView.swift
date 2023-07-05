import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    @State private var loginComplete: Bool = false
    @State private var errorMessage: String = ""
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue) 
            
            TextFieldView(
                title: "Username",
                text: $viewModel.username
            )
            PasswordFieldView(
                title: "Password",
                password: $viewModel.password
            )
            
            AuthButton(buttonText: "Login", action: login)
            NavigationLink(destination: CategoryList(),isActive: $loginComplete){
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
    private func login() {
        Task {
            do {
                try await viewModel.loginUser()
                loginComplete = true
            } catch {
                DispatchQueue.main.async {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LoginViewModel()
        
        LoginView(viewModel: viewModel)
    }
}
