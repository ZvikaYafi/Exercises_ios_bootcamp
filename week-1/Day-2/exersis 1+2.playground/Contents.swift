import UIKit

func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    //Checking whether the diameter or the number of slices is equal to nothing
    guard let diameter = diameter, let slices = slices else {
        return nil
    }
    //Checking whether the diameter is negative or the number of slices is less than 1
    if diameter < 0 || slices < 1 {
        return nil
    }
    //The logic of the calculation is based on the formula pi * (r**)
    let radius = diameter / 2
    let area = Double.pi * pow(radius, 2)
    
    //Calculation of the amount of slices according to the calculation of area divided by the amount of slices
    let sliceArea = area / Double(slices)
    
    return sliceArea
}


// 2
func biggestSlice(diameterA: String, slicesA: String, diameterB: String, slicesB: String) -> String {
    
    guard let diameterADouble = Double(diameterA),
          let slicesAInt = Int(slicesA),
          let diameterBDouble = Double(diameterB),
          let slicesBInt = Int(slicesB) else {
        return "Neither slice is bigger"
    }
    
    guard let sliceASize = sliceSize(diameter: diameterADouble, slices: slicesAInt),
          let sliceBSize = sliceSize(diameter: diameterBDouble, slices: slicesBInt) else {
        return "Neither slice is bigger"
    }
    
    if sliceASize > sliceBSize {
        return "Slice A is bigger"
    }
    
    if sliceASize < sliceBSize {
        return "Slice B is bigger"
    }
    
    return "Neither slice is bigger"
}



print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "14", slicesB: "12"))
print(biggestSlice(diameterA: "10", slicesA: "6", diameterB: "12", slicesB: "8"))
print(biggestSlice(diameterA: "Pepperoni", slicesA: "6", diameterB: "Sausage", slicesB: "12"))
