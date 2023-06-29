import SwiftUI

struct CommentsView: View {
    
    // Create an observed object `commentsViewModel` of type `CommentsViewModel`
    @ObservedObject var commentsViewModel = CommentsViewModel()
    
    // Declare a constant property `post` of optional type `Post`
    let post: Post?

    // Define the body of the view
    var body: some View {
        // Create a vertical stack (`VStack`) container
        VStack {
            // Check if `commentsViewModel.comments` has a non-nil value
            if let comments = commentsViewModel.comments {
                // Create a list that displays the `comments`
                List(comments) { comment in
                    HStack {
                       
                        // Display the comment's body
                        Text(comment.body ?? "")
                            .foregroundColor(.primary)
                            .lineLimit(.max)
                            .padding(.trailing, 10)
                    }
                }
                // Apply bottom padding to the list
                .padding(.bottom, 20)
            }
        }
        // Trigger the `getComments` method when the view appears
        .onAppear {
            self.commentsViewModel.getComments(postId: post?.id ?? 0)
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: Post(userId: 4, id: 0, title: "Sample Title", body: "Sample Body"))
    }
}
