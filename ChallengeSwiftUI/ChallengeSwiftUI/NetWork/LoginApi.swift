
import Foundation

class LoginApi {
    
    static var shared = LoginApi()
    
    private let loginURL = "https://balink.onlink.dev/users/login"
    
    // login  and send token to product api
    func login(userName: String, password: String) async throws {
        if let url = URL(string: loginURL) {
            var request = URLRequest(url: url)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
            
            let parameters: [String: String] = [
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
            if let res = response as? HTTPURLResponse ,
               res.statusCode == 200 {
                
                let parsedUser = try self.parseJSON(userData: data)
                print(parsedUser)
                ProductApi.shared.token = parsedUser.token
            }
             
           
     
        }
    }
   
    // Parse json to come from  server
    func parseJSON(userData: Data) throws -> User {
        let decoder = JSONDecoder()
        return try decoder.decode(User.self, from: userData)
        
    }
}
