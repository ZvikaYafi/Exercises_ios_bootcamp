import SwiftUI
import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    
    var token: String?
    
    func registerUser() async throws {
        try await RegisterApi.shared.createUser(firstName: firstName, lastName: lastName, userName: username, password: password)
    }
}
