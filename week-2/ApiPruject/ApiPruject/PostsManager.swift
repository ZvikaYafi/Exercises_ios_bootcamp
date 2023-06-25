import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct PostsManager {
    
    static let postsURL = "https://jsonplaceholder.typicode.com/posts"
    
    static func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)  {
        
        if let url = URL(string: postsURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url)  { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                if let safeData = data {
                    let parsedPosts = parseJSON(postsData: safeData)
                    completion(.success(parsedPosts))
                }
            }
            task.resume()
        }
    }
    
    func getAllTitle(){
        
        
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
