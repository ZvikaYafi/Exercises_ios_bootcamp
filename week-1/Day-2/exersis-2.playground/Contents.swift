import UIKit

// 2
//A function that accepts the size of 2 pizzas and the number of slices and returns a string of which is larger
func biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String {
    
//try to convert the strings to a double or a int
    if let diameterADouble = Double(diameterA),
       let slicesAInt = Int(slicesA),
       let diameterBDouble = Double(diameterB),
       let slicesBInt = Int(slicesB) {
        
//Attempt to get the size of the slice with the previous function
        if let sliceASize = sliceSize(diameter: diameterADouble, slices: slicesAInt),
           let sliceBSize = sliceSize(diameter: diameterBDouble, slices: slicesBInt) {
            
//If it succeeds in returning the pizza with the largest slice
            if sliceASize > sliceBSize {
                return "Slice A is bigger"
            } else if sliceASize < sliceBSize {
                return "Slice B is bigger"
            } else {
                return "Neither slice is bigger"
            }
        }
    }
//If there is an error in one of the processes returns
    return "Neither slice is bigger"
}


print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12"))
print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8"))
print(biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "Sausage", slicesB: "12"))
