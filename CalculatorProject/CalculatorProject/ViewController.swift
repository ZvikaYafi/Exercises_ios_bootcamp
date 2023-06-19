import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numbersToCalculate: UILabel!
    @IBOutlet weak var Result: UILabel!
    
    var numberInput: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func One(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        numberInput.append(numberValue)
        numbersToCalculate.text = numberInput
    }
    
    @IBAction func Plus(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        numberInput.append(numberValue)
        numbersToCalculate.text = numberInput
    }
    
    @IBAction func equal(_ sender: UIButton) {
        guard !numberInput.isEmpty else { return }
        
        var num1 = 0
        var num2 = 0
        var operatorFound = false
        var typeOperator = ""
        
        for char in numberInput {
            if let number = Int(String(char)) {
                if !operatorFound {
                    num1 = (num1 * 10) + number
                    print(num1 , "num1")
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
            }else{
                Result.text = "Error"
            }
        default:
            Result.text = "Error"
            return
        }

        Result.text = String(result)
    }

    @IBAction func clear(_ sender: UIButton) {
        Result.text = "0"
        numberInput=""
        numbersToCalculate.text = "0"

    }
    
    
}
