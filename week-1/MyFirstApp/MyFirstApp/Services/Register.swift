

import Foundation

class Register {
    
    static var shared = Register()
    
    private let registerURL = "https://balink.onlink.dev/register"
    
    func registerUser(firstName: String, lastName: String, userName: String, password: String) async throws {
        if let url = URL(string: registerURL) {
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            request.httpMethod = "POST"
            
            let parameters: [String: String] = [
                "firstname": firstName,
                "lastname": lastName,
                "username": userName,
                "password": password
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = jsonData
            } catch {
                //hendle error
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
             
            let token = String(data: data, encoding: .utf8)
            ProductApi.shared.token = token
            
            
        }
    }
}
