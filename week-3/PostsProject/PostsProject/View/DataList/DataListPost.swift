import SwiftUI

// Define a struct named `DataListPost` that conforms to the `View` protocol
struct DataListPost: View {
    
    // Create an observed object `userViewModel` of type `UserViewModel`
    @ObservedObject var userViewModel = UserViewModel()
    
    // Declare a constant property `post` of optional type `Post`
    let post: Post?
    
    // Define the body of the view
    var body: some View {
        // Create a vertical stack (`VStack`) container with vertical spacing of 20
        VStack(spacing: 20) {
            // Check if `userViewModel.user` has a non-nil value
            if let user = userViewModel.user {
                // Create a nested vertical stack (`VStack`) container with vertical spacing of 10
                VStack(spacing: 10) {
                    // Display the user's name
                    Text(user.name ?? "")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                    
                    // Display the user's username
                    Text("Username: \(user.username ?? "")")
                        .foregroundColor(.gray)
                    
                    // Display the user's email
                    Text("Email: \(user.email ?? "")")
                        .foregroundColor(.gray)
                    
                    // Display the user's phone number
                    Text("Phone: \(user.phone ?? "")")
                        .foregroundColor(.gray)
                }
                // Apply bottom padding of 30 to the nested vertical stack
                .padding(.bottom, 30)
            }
            
            // Check if `post` has a non-nil value
            if let post = post {
                // Create a nested vertical stack (`VStack`) container with vertical spacing of 10
                VStack(spacing: 10) {
                    // Display the post's title
                    Text(post.title ?? "")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    // Display the post's body
                    Text(post.body ?? "")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    
                    // Create a navigation link to navigate to the `CommentsView` passing the `post` as a parameter
                    NavigationLink(destination: CommentsView(post: post)) {
                        // Display the "Show comments" text with blue color
                        Text("Show comments")
                            .foregroundColor(.blue)
                    }
                }
                // Apply leading and trailing padding of 20 to the nested vertical stack
                .padding([.leading, .trailing], 20)
            }
        }
        // Apply top and bottom padding of 20 to the main vertical stack
        .padding([.top, .bottom], 20)
        // Trigger the `getUser` method when the view appears
        .onAppear {
            self.userViewModel.getUser(userId: post?.userId ?? 1)
        }
    }
}

struct DataListPost_Previews: PreviewProvider {
    static var previews: some View {
        DataListPost(post: Post(userId: 4, id: 0, title: "Sample Title", body: "Sample Body"))
    }
}
