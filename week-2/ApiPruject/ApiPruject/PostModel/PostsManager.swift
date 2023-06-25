import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class PostsManager {
    
    let postsURL = "https://jsonplaceholder.typicode.com/posts"
    
    static let shared = PostsManager()
    
    var posts : [Post] = []
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void)  {
        
        if let url = URL(string: postsURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url)  { (data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                if let safeData = data {
                    let parsedPosts = self.parseJSON(postsData: safeData)
                    self.posts = parsedPosts
                    completion(.success(parsedPosts))
                }else {
                    completion(.failure("error json" as! Error))
                }
            }
            task.resume()
        }
    }
    
    
    func getAllTitle() -> [String] {
        return posts.map { $0.title }
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
