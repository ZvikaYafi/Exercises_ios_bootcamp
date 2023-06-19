import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct PostsManager {
    
    static let postsURL = "https://jsonplaceholder.typicode.com/posts"
    
    static func fetchPosts(completion: @escaping ([Post]) -> Void) {
        
        if let url = URL(string: postsURL) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url)  { (data, response, error) in
                if let error = error {
                                
                    return
                }
                
                if let safeData = data {
                    let parsedPosts = self.parseJSON(postsData: safeData)
                    completion(parsedPosts)
                }
            }
            task.resume()
        }
    }
    
    static func parseJSON(postsData: Data) -> [Post] {
        let decoder = JSONDecoder()
        do {
            let posts = try decoder.decode([Post].self, from: postsData)
            return posts
        } catch {
            print("error \(error)")
            return []
        }
    }
}
