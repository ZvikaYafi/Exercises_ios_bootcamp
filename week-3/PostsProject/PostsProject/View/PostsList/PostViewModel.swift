import Foundation


class PostViewModel: ObservableObject {
    
    @Published var posts: [Post]?
    
    func getPosts() {
        
        // Define a method named `getPosts`
        PostApi.shared.fetchPosts() { result in
            // Call the `fetchPosts` method from the `PostApi`
            
            switch result {
                
                // If the API call is successful, extract the `posts` array from the result
            case .success(let posts):
                
                DispatchQueue.main.async {
                    self.posts = posts
                }
                // If the API call fails, extract the `error` object from the result and print it
            case .failure(let error):
                
                print(error)
            }
        }
    }
}
