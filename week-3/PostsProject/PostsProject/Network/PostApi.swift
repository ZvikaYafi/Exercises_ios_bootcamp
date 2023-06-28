import Foundation


struct PostApi {
    
    let postsURL = "https://jsonplaceholder.typicode.com/posts"
    
    static let shared = PostApi()
    
    // Define a method named `fetchPosts` that takes a completion closure as a parameter
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        
        // Create a URL object from the `postsURL`
        if let url = URL(string: postsURL) {
            
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                // If data is successfully fetched, parse it using the `parseJSON` method and call the completion closure with the parsed posts as a success result
                if let safeData = data {
                    let parsedPosts = self.parseJSON(postsData: safeData)
                    completion(.success(parsedPosts))
                } else {
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
