import UIKit


class ViewController: UIViewController {
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostsManager.fetchPosts { fetchedPosts in
            DispatchQueue.main.async {
                self.posts = fetchedPosts
 
                print(self.posts)
            }
        }
    }
}
