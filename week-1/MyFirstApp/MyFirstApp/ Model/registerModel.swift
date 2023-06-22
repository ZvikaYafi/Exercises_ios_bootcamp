import Foundation

class registerModel {
    
    static let shared = registerModel()
    
    private let registerURL = "https://balink.onlink.dev/register"
    
    func registerUser(firstName: String, lastName: String, userName: String, password: String, completion: @escaping (String?) -> Void) {
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
                print("Error encoding parameters to json:", error)
                completion(nil)
                return
            }
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error:", error)
                    completion(nil)
                    return
                }
                
                if let data = data,
                   var token = String(data: data, encoding: .utf8) {
                    completion(token)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
}
