import UIKit

// 1
//A function that accepts an optional diameter and an optional number of slices and returns a slice size
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

print(sliceSize(diameter: 16, slices: 12))

print(sliceSize(diameter: nil, slices: 8))







