import UIKit

// 3

func applyKTimes(_ K: Int, _ closure: ()-> Void) {
    for _ in 1...K {
        closure()
    }
}

applyKTimes(10) {
    print("We Heart Swift")
}
