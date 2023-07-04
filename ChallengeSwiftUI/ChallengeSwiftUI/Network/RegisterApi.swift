
import Foundation

class RegisterApi {
    
    static var shared = RegisterApi()
    
    private let registerURL = "https://balink.onlink.dev/users/register"
    
    // create user and send token to product api
    func createUser(firstName: String, lastName: String, userName: String, password: String) async throws {
        
        guard isInputValid(
            firstname: firstName,
            lastname: lastName,
            username: userName,
            password: password)
        else {return}
        
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
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let token = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(token, forKey: "AuthToken")

        }
    }
    
    // Check all inputs if its ok
    func isInputValid(firstname: String, lastname: String, username: String, password: String) -> Bool {
        let nameRegex = #"^[a-zA-Z0-9]+$"#
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        
        let isFirstNameValid = firstname.matches(nameRegex)
        let isLastNameValid = lastname.matches(nameRegex)
        let isUsernameValid = username.matches(emailRegex)
        
        return isFirstNameValid && isLastNameValid && isUsernameValid
    }
    
    
}

// extension String 
extension String {
    func matches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}
