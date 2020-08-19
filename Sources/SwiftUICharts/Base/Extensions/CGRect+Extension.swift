import Foundation
import SwiftUI

extension CGRect {

/// Midpoint of rectangle
	/// - Returns: the coordinate for a rectangle center
    public var mid: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}
