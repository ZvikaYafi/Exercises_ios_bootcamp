
import Foundation

struct UserApi  {
    
     
     static let shared = UserApi()
     
    func fetchUser(userId: Int ,completion: @escaping (Result<User, Error>) -> Void)  {
         
         if let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)") {
             let session = URLSession(configuration: .default)
             let task = session.dataTask(with: url)  { (data, response, error) in
                 
                 if let error = error {
                     completion(.failure(error))
                 }
                 
                 if let safeData = data {
                     if let parsedUser = self.parseJSON(UserData: safeData){
                         
                         completion(.success(parsedUser))
                     }
                 }else {
                     completion(.failure("error json" as! Error))
                 }
             }
             task.resume()
         }
     }
    

  
     func parseJSON(UserData: Data) -> User? {
         let decoder = JSONDecoder()
         do {
             let user = try decoder.decode(User.self, from: UserData)
             return user
         } catch {
             print()
             return nil
         }
     }
}
