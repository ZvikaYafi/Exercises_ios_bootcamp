import SwiftUI

struct ContentView: View {
    
    // Create an observed object `postViewModel` of type `PostViewModel`
    @ObservedObject var postViewModel = PostViewModel()
    
    // Define the body of the view
    var body: some View {
        // Embed the view in a navigation view
        NavigationView {
            // Check if `postViewModel.posts` has a non-nil value
            if let posts = postViewModel.posts {
                // Create a list view (`List`) with `posts` as the data source
                List(posts) { post in
                    // Create a navigation link to navigate to the `DataListPost` view passing the `post` as a parameter
                    NavigationLink(destination: DataListPost(post: post)) {
                        // Create a horizontal stack (`HStack`) container
                        HStack {
                            // Display the post's ID
                            Text("\(post.id ?? 0)")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            
                            // Display the post's title
                            Text(post.title ?? "")
                                .foregroundColor(.primary)
                                .lineLimit(2)
                        }
                    }
                }
                // Apply bottom padding of 20 to the list view
                .padding(.bottom, 20)
                // Set the navigation bar title to "Posts" with inline display mode
                .navigationBarTitle("Posts", displayMode: .inline)
            } else {
                // Display a progress view if `postViewModel.posts` is nil (loading state)
                ProgressView()
            }
        }
        // Trigger the `getPosts` method when the view appears
        .onAppear {
            self.postViewModel.getPosts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
