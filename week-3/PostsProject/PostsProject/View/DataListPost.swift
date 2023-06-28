import SwiftUI

struct DataListPost: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    
    let post: Post?
    
    var body: some View {
        VStack(spacing: 20) {
            // User Details
            if let user = userViewModel.user {
                VStack(spacing: 10) {
                    Text(user.name ?? "")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                    
                    Text("Username: \(user.username ?? "")")
                        .foregroundColor(.gray)
                    
                    Text("Email: \(user.email ?? "")")
                        .foregroundColor(.gray)
                    
                    Text("Phone: \(user.phone ?? "")")
                        .foregroundColor(.gray)
                }
                .padding(.bottom,200)
            }
            
            if let post = post {
                VStack(spacing: 10) {
                    Text(post.title ?? "")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    Text(post.body ?? "")
                        .foregroundColor(.gray)
                }
            }
        }
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
