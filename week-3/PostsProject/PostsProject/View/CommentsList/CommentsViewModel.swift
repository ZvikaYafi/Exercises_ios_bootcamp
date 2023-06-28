import Foundation


class CommentsViewModel: ObservableObject {
    
    @Published var comments: [Comment]?
    
    // Define a method named `getComments` that takes a `postId` parameter of type `Int`
    func getComments(postId: Int) {
        
        // Call the `fetchComments` method from the `CommentApi` with the `postId` parameter
        CommentApi.fetchComments(postId: postId) { result in
            
            switch result {
                
                // If the API call is successful, extract the `comments` array from the result
            case .success(let comments):
                
                
                DispatchQueue.main.async {
                    self.comments = comments
                }
                // If the API call fails, extract the `error` object from the result and print it
            case .failure(let error):
                print(error)
            }
        }
    }
}
