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

// 3
func applyKTimes(_ K: Int, _ closure: () -> ()) {
    for _ in 1...K {
        closure()
    }
}

applyKTimes(10) {
    print("We Heart Swift")
}

// 4
//Defining a variable with optional values
enum Direction {
    case up
    case down
    case right
    case left
}
//A function that receives an initial position and moves and returns a new position
func calculateFinalLocation(initialLocation: (y: Int, x: Int), steps: [Direction]) -> (y: Int,x: Int) {
    
    var finalLocation = initialLocation
    
    //Calculation of the new place
    for step in steps {
        switch step {
        case .up:
            finalLocation.x += 1
        case .down:
            finalLocation.x -= 1
        case .right:
            finalLocation.y += 1
        case .left:
            finalLocation.y -= 1
        }
    }

    return finalLocation
}
//Setting the initial location
var location = (y: 0, x: 0)

//Setting the amount of movements
var steps: [Direction] = [.up, .up, .left, .down, .left,]

let finalLocation = calculateFinalLocation(initialLocation: location, steps: steps)

print(finalLocation)

