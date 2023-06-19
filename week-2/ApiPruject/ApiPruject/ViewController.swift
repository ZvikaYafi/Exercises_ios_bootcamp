
import UIKit

class ViewController: UIViewController {
 
    var postsManager = PostsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsManager.fetchPosts()
    }

}

