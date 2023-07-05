import SwiftUI

struct ContentView: View {
    
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to challenge app")
                    .font(.custom("Pacifico-Regular", size: 30))
                    .fontWeight(.bold)
                    .padding(.bottom, 100)
                    .foregroundColor(.blue)
                
                ButoonView(destination:RegistrationView(viewModel: registrationViewModel), title: "Sing-Up")
                ButoonView(destination: LoginView(viewModel: loginViewModel), title: "Log-In")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
