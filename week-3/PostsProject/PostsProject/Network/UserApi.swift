import Foundation

struct UserApi {
    
    static let shared = UserApi()
    
    // Fetches user data for a given userId
    func fetchUser(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        
        // Construct the URL for fetching user data based on the userId
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    // Call the completion closure with a failure result if there's an error
                    completion(.failure(error))
                }
                
                if let safeData = data {
                    // Parse the fetched data using the parseJSON method
                    if let parsedUser = self.parseJSON(UserData: safeData) {
                        // Call the completion closure with a success result containing the parsed user data
                        completion(.success(parsedUser))
                    }
                } else {
                    completion(.failure("error json" as! Error))
                }
            }
            
            task.resume()
        }
    }
    
    // Parses JSON data into a User object
    func parseJSON(UserData: Data) -> User? {
        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(User.self, from: UserData)
            return user
        } catch {
            // If decoding fails, return nil
            print()
            return nil
        }
    }
}
