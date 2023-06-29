

import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    
   
    @Published var username: String = ""
    @Published var password: String = ""
    
    var token: String?
    
    func LoginUser() async throws {
        try await LoginApi.shared.login(userName: username, password: password)
    }
}
