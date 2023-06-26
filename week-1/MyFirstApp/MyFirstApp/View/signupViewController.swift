import UIKit

class signupViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign-up"
    }
    
    @IBAction func singUpButton(_ sender: UIButton) {
        
            guard let firstNameText = firstName.text,
                  let lastNameText = lastName.text,
                  let userNameText = userName.text,
                  let passwordText = password.text else { return }
        Task {
           try await  Register.shared.registerUser(firstName: firstNameText, lastName: lastNameText, userName: userNameText, password: passwordText)
            self.performSegue(withIdentifier: "HomeScreen2", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userName = firstName?.text ?? ""
        if segue.identifier == "HomeScreen2" {
            let destinationVC = segue.destination as? TableCategoryViewController
            destinationVC?.userName = userName
        }
    }
}
