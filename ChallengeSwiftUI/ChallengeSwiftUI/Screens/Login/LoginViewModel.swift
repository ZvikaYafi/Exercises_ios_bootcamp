
import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    func loginUser() async throws {
        if isInputValid(username: username, password: password) {
            do {
                try await LoginApi.shared.login(userName: username, password: password)
            } catch {
                print("Error: \(error.localizedDescription)")
                throw error
            }
        } else {
            throw NSError(domain: "invalid input", code: 501)
        }
    }
    
    private func isInputValid(username: String, password: String) -> Bool {
        
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isUsernameValid = username.matches(emailRegex)
        
        return isUsernameValid
    }
}


