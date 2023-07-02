import SwiftUI

struct ContentView: View {
    
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to challenge app")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 200)
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
