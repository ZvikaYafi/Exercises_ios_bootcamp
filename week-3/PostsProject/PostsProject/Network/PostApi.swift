
import Foundation

struct PostApi  {
    
    let postsURL = "https://jsonplaceholder.typicode.com/posts"
     
     static let shared = PostApi()
     
     func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)  {
         
         if let url = URL(string: postsURL) {
             let session = URLSession(configuration: .default)
             let task = session.dataTask(with: url)  { (data, response, error) in
                 
                 if let error = error {
                     completion(.failure(error))
                 }
                 
                 if let safeData = data {
                     let parsedPosts = self.parseJSON(postsData: safeData)
                     completion(.success(parsedPosts))
                 }else {
                     completion(.failure("error json" as! Error))
                 }
             }
             task.resume()
         }
     }
     
     
     func parseJSON(postsData: Data) -> [Post] {
         let decoder = JSONDecoder()
         do {
             let posts = try decoder.decode([Post].self, from: postsData)
             return posts
         } catch {
             print()
             return []
         }
     }
}
