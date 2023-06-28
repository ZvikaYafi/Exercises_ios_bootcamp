import Foundation

struct CommentApi {
    
    // Fetches comments for a given postId
    static func fetchComments(postId: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        // Construct the URL for fetching comments based on the postId
        if let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    // Call the completion closure with a failure result if there's an error
                    completion(.failure(error))
                }
                
                if let safeData = data {
                    // Parse the fetched data using the parseJSON method
                    let parsedComments = self.parseJSON(commentsData: safeData)
                    
                    // Call the completion closure with a success result containing the parsed comments
                    completion(.success(parsedComments))
                } else {
                    completion(.failure("error json" as! Error))
                }
            }
            
            task.resume()
        }
    }
    
    // Parses JSON data into an array of Comment objects
    static func parseJSON(commentsData: Data) -> [Comment] {
        let decoder = JSONDecoder()
        do {
            let comments = try decoder.decode([Comment].self, from: commentsData)
            return comments
        } catch {
            // If decoding fails, return an empty array
            return []
        }
    }
}
