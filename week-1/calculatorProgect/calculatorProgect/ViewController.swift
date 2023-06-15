import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numbersToCalculate: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    var numberInput: String = ""
    var arreyOfReslut: [String] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calculator"
    }
 
    // A function that takes the numbers the user enters and displays them on the screen
    @IBAction func One(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        numberInput.append(numberValue)
        numbersToCalculate.text = numberInput
    }
    
    // A function that takes the operator the user enters and displays them on the screen
    @IBAction func Plus(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        numberInput.append(numberValue)
        numbersToCalculate.text = numberInput
    }
    
    // A function that calculates the result and displays them on the screen
    @IBAction func equal(_ sender: UIButton) {
        guard !numberInput.isEmpty else { return }
        
        var num1 = 0
        var num2 = 0
        var operatorFound = false
        var typeOperator = ""
        
        // A loop that returns the numbers that the user entered and saves the operator
        for char in numberInput {
            if let number = Int(String(char)) {
                if !operatorFound {
                    num1 = (num1 * 10) + number
                    print(num1, "num1")
                } else {
                    num2 = (num2 * 10) + number
                    print(num2, "num2")
                }
            } else {
                operatorFound = true
                typeOperator = String(char)
            }
        }
        
        var result: Double = 0.0
        
        // Finding the correct operator and returning an answer according to the operator and the numbers
        print("\(num1) \(typeOperator) \(num2)")
        switch typeOperator {
        case "+":
            result = Double(num1 + num2)
        case "-":
            result = Double(num1 - num2)
        case "*":
            result = Double(num1 * num2)
        case "/":
            if num2 != 0 {
                result = Double(num1) / Double(num2)
            } else {
                Result.text = "Error"
            }
        default:
            Result.text = "Error"
            return
        }
        
        arreyOfReslut.append("\(num1) \(typeOperator) \(num2) = \(result)")
        Result.text = String(result)
        print(arreyOfReslut)
        

    }

    // A function that clears the screen for a new exercise
    @IBAction func clear(_ sender: UIButton) {
        Result.text = "0"
        numberInput = ""
        numbersToCalculate.text = "0"
    }

    @IBAction func gohistory(_ sender: UIButton) {
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goHistory" {
            let destinationVC = segue.destination as! HViewController
            destinationVC.historyArray = arreyOfReslut
        }
    }
}
