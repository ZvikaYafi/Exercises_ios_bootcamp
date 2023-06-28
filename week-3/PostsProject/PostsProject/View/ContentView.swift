import SwiftUI

struct ContentView: View {
    
    @ObservedObject var postViewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            if let posts = postViewModel.posts {
                List(posts) { post in
                    NavigationLink(destination: DataListPost(post: post)) {
                        HStack {
                            Text("\(post.id ?? 0)")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 30)
                            
                            Text(post.title ?? "")
                                .foregroundColor(.primary)
                                .lineLimit(2)
                        }
                    }
                }
                .padding(.bottom, 20)
                .navigationBarTitle("Posts", displayMode: .inline)
            } else {
                ProgressView()
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

