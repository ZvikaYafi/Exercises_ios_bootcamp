import SwiftUI

struct ContentView: View {
    
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    @State private var title = ""
    
    var body: some View {
        NavigationStack {
            
                VStack(spacing: 20) {
                    Text(title)
                        .font(.custom("Pacifico-Regular", size: 30))
                        .padding(.bottom, 150)
                        .foregroundColor(.blue)
                    
                    // Custom view
                    ButtonView(destination: RegistrationView(viewModel: registrationViewModel), title: "Sign-Up")
                    ButtonView(destination: LoginView(viewModel: loginViewModel), title: "Log-In")
                }
                .onAppear { updateTitle() }
                .padding()
           
        }
    }
    
    // Animation of the title
    private func updateTitle() {
        self.title = ""
        var charIndex = 0.0
        let newTitle = "Welcome to my app"
        
        for letter in newTitle {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.title.append(letter)
                }
            }
            charIndex += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
