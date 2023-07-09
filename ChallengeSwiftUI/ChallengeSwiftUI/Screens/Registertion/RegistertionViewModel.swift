import SwiftUI
import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    // A function that register user
    func registerUser() async throws {
        if isInputValid(firstname: firstName, lastname: lastName, username: username, password: password) {
            do {
                try await RegisterApi.shared.createUser(firstName: firstName, lastName: lastName, userName: username, password: password)
            } catch {
                throw error
            }
        } else {
            throw NSError(domain: "invalid input", code: 501)
        }
    }
    
    // A function that checks input validation
    private func isInputValid(firstname: String, lastname: String, username: String, password: String) -> Bool {
        let nameRegex = #"^[a-zA-Z0-9]+$"#
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        
        let isFirstNameValid = firstname.matches(nameRegex)
        let isLastNameValid = lastname.matches(nameRegex)
        let isUsernameValid = username.matches(emailRegex)
        
        return isFirstNameValid && isLastNameValid && isUsernameValid
    }
}

enum RegistrationError: Error {
    case invalidInput
}
