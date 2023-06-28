

import Foundation

class PostViewModel: ObservableObject {
    
    @Published var posts :[Post]?
    
    func getPosts() {
        PostApi.shared.fetchPosts() { result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
