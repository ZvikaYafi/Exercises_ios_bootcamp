import UIKit

// 1
//A function that receives a rate and returns a total for the day
func dailyRateFrom(hourlyRate: Double) -> Double {
    return hourlyRate * 8
}


// 2
//A function that receives a number of hours and a discount percentage and calculates a monthly price
func monthlyRateFrom(hourlyRate: Double, withDiscount: Double) -> Double {
    
    //Daily calculation according to the given rate
    let dailyRate = dailyRateFrom(hourlyRate: hourlyRate)
    
    //Calculation per month according to the given rate
    let totalMonthlyRate = dailyRate * 22
    
   // Calculation of the discount amount
    let discountAmount = totalMonthlyRate * (withDiscount / 100.0)
    
    return round(totalMonthlyRate - discountAmount)
  
}
// 3
// A function that calculates working days according to a given budget, working hours and a discount percentage
func workdaysIn(budget: Double, hourlyRate: Double, withDiscount: Double) -> Double {
    
    //Calculation per month according to the given rate
    let monthlyRate = monthlyRateFrom(hourlyRate: hourlyRate, withDiscount: withDiscount)
    
    //Calculation of how many months are included in the given budget
    let numberOfMonths = budget / monthlyRate

    //Calculation of how many working days come in a month
    let totalWorkdays = numberOfMonths * 22

    return round(totalWorkdays)
}


print(dailyRateFrom(hourlyRate:60))
print(monthlyRateFrom(hourlyRate: 77, withDiscount: 10.5))
print(workdaysIn(budget: 20000, hourlyRate: 80, withDiscount: 11))
