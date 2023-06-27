
import SwiftUI


struct ContentView: View {
    
    @ObservedObject var postViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            if let posts = postViewModel.posts {
                List(posts) { post in
                    Text(post.title ?? "")
                }
            }
        }
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
