import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct PostsManager {
    
    let postsURL = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts() {
        if let url = URL(string: postsURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url)  { (data, response, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let safeData = data {
                    let parsedPosts = self.parseJSON(postsData: safeData)
                    print(parsedPosts)
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
            print("error \(error)")
            return []
        }
    }
}




