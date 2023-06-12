import UIKit

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
