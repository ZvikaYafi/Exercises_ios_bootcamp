import Foundation

struct CalculatorLogic {
    var number1: String
    var number2: String
    var operation: String
    
   
    func checkNumber(_ number: String?) -> Bool {
        
        guard let isTrue = number else {
            return false
        }
        guard let isNumber = Int(isTrue) else {
            return false
        }
            return true
        }
        
        
        func performOperation() -> Double {
            if !self.checkNumber(number1) || !self.checkNumber(number2) {
                return 0.0
            }
            
            guard let num1 = Int(number1), let num2 = Int(number2) else {
                return 0.0
            }
            switch operation {
            case "+":
                return Double(num1 + num2)
            case "-":
                return Double(num1 - num2)
            case "*":
                return Double(num1 * num2)
            case "/":
                return Double(num1 / num2)
            default:
                return 0.0
            }
        }
    
}


