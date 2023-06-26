

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log-in"
        
    }
    
    func isValidUserName(userName: String) -> Bool {
        let res = userName.range(of: #"^[a-zA-Z]+$"#, options: .regularExpression) != nil
        return res
    }
    
    func isValidpassword(password: String) -> Bool {
        let res = password.count >= 6
        return res
    }
    
    @IBAction func LoginButtonIsPressed(_ sender: UIButton) {
        guard let name = userName?.text,
              let pass = password?.text else {return}
        
        if isValidUserName(userName:name),
           isValidpassword(password: pass){
            self.performSegue(withIdentifier: "HomeScreen", sender: self)
        } else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userName = userName?.text ?? ""
        if segue.identifier == "HomeScreen" {
            let destinationVC = segue.destination as? TableCategoryViewController
            destinationVC?.userName = userName
        }
    }
    
}
