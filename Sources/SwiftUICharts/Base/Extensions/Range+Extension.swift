import Foundation

public extension ClosedRange where Bound: AdditiveArithmetic {
    var overreach: Bound {
        self.upperBound - self.lowerBound
    }
}
