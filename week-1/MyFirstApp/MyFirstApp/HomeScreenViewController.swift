import UIKit


class HomeScreenViewController: UIViewController {
  
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Welcome \(userName)"
    }
    
 
    
}
