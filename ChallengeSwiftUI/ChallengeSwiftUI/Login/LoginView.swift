import SwiftUI

struct LoginView: View {
    
    
    @StateObject var viewModel: LoginViewModel
    @State private var loginComplete: Bool = false
    
    
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
    }
    private func login() {
        Task {
            do {
                try await viewModel.LoginUser()
                loginComplete = true
            } catch {
                print(error)
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
