
import UIKit

class signupViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign-up"
        
    }
    
    @IBAction func SignUp(_ sender: UIButton) {
        
    }
    
    
}
