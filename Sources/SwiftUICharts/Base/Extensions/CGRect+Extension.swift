import Foundation
import SwiftUI

extension CGRect {

	/// Midpoint of rectangle
	/// - Returns: the coordinate for a rectangle center
    public var mid: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }

    /// Returns a rectangle with finite origin and non-negative finite size.
    public var sanitized: CGRect {
        CGRect(x: origin.x.isFinite ? origin.x : 0,
               y: origin.y.isFinite ? origin.y : 0,
               width: max(0, size.width.isFinite ? size.width : 0),
               height: max(0, size.height.isFinite ? size.height : 0))
    }
}

extension CGSize {
    /// Returns a size with non-negative finite width and height.
    public var sanitized: CGSize {
        CGSize(width: max(0, width.isFinite ? width : 0),
               height: max(0, height.isFinite ? height : 0))
    }
}
