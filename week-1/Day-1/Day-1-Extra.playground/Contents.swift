import UIKit

// Task 1: Compute whether or not you can afford the monthly payments on a given car
func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
    
    //Calculation of the monthly cost of the vehicle
    let monthlyPayment = price / 60.0
    
    // The calculation of the monthly repayment includes an exception of 10%
    let maxMonthlyPayment = monthlyBudget * 1.1
    
    //The calculation logic
    if monthlyPayment <= monthlyBudget  {
        return "Yes! I'm getting a \(vehicle)"
    } else if monthlyPayment <= maxMonthlyPayment {
        return "I'll have to be frugal if I want a \(vehicle)"
    } else {
        return "Darn! No \(vehicle) for me"
    }
}

print(canIBuy(vehicle: "1974 Ford Pinto", price: 516.32, monthlyBudget: 100.00))
print(canIBuy(vehicle: "2011 Bugatti Veyron", price: 2250880.00, monthlyBudget: 10000.00))
print(canIBuy(vehicle: "2020 Indian FTR 1200", price: 12500, monthlyBudget: 200.00))

// Task 2: Determine the type of drivers license you will need
func licenseType(numberOfWheels: Int) -> String {
    //The logic of the calculation according to the number of wheels
    switch numberOfWheels {
    case 2, 3:
        return "You will need a motorcycle license for your vehicle"
    case 4, 6:
        return "You will need an automobile license for your vehicle"
    case 18:
        return "You will need a commercial trucking license for your vehicle"
    default:
        return "We do not issue licenses for those types of vehicles"
    }
}

print(licenseType(numberOfWheels: 2))
print(licenseType(numberOfWheels: 6))
print(licenseType(numberOfWheels: 18))
print(licenseType(numberOfWheels: 0))


func registrationFee(msrp: Int, yearsOld: Int) -> Int {
    //
    if yearsOld >= 10 {
        return 25
    } else {
        //get the big number
        let baseCost = max(msrp, 25000)
        var fee = baseCost
        
        let deduction = Int(Double(fee) * 0.1)
        for _ in 0..<yearsOld {
            fee -= deduction
        }
        return fee / 100
    }
}

print(registrationFee(msrp: 2250800, yearsOld: 9))
print(registrationFee(msrp: 25000, yearsOld: 3))
print(registrationFee(msrp: 34000, yearsOld: 30))



