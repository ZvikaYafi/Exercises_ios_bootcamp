import UIKit

class ViewController: UIViewController {
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostsManager.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    
                case .failure(let error):
                    print(error)
                }
                print(self.posts)
            }
        }
    }
}
