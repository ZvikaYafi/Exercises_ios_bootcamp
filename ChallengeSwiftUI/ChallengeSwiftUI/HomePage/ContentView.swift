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
                
                NavigationLink(destination: RegistrationView(viewModel: registrationViewModel)) {
                    Text("Sign-Up")
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
                
                NavigationLink(destination: LoginView(viewModel: loginViewModel)) {
                    Text("Log-In")
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
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
