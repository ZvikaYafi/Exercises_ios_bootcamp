import Foundation

class RegisterApi {
    
    static var shared = RegisterApi()
    
    private let registerURL = "https://balink.onlink.dev/users/register"
    
    // create user and send token to product api
    func createUser(firstName: String, lastName: String, userName: String, password: String) async throws {
        
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
                throw RegistrationErrorApi.invalidRequest
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let res = response as? HTTPURLResponse,
               res.statusCode == 201 {
                
                let token = try JSONDecoder().decode(Token.self, from: data)
                
                UserDefaults.standard.set(token.token, forKey: "AuthToken")
            }
        }
        else {
            throw RegistrationErrorApi.invalidURL
        }
    }
}

enum RegistrationErrorApi: Error {
    case invalidRequest
    case invalidResponse
    case invalidURL
}


// extension String
extension String {
    func matches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}

struct Token: Codable {
    let token: String
}
