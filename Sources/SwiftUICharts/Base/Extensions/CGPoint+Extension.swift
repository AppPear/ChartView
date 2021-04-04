import SwiftUI

extension CGPoint {
	
	/// Calculate X and Y delta for each data point, based on data min/max and enclosing frame.
	/// - Parameters:
	///   - frame: Rectangle of enclosing frame
	///   - data: array of `Double`
	/// - Returns: X and Y delta as a `CGPoint`
    static func getStep(frame: CGRect, data: [Double]) -> CGPoint {
        let padding: CGFloat = 0

        // stepWidth
        var stepWidth: CGFloat = 0.0
        if data.count < 2 {
            stepWidth = 0.0
        }
        stepWidth = frame.size.width / CGFloat(data.count - 1)

        // stepHeight
        var stepHeight: CGFloat = 0.0

        var min: Double?
        var max: Double?
        if let minPoint = data.min(), let maxPoint = data.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        } else {
            return .zero
        }
        if let min = min, let max = max, min != max {
            if min <= 0 {
                stepHeight = (frame.size.height - padding) / CGFloat(max - min)
            } else {
                stepHeight = (frame.size.height - padding) / CGFloat(max + min)
            }
        }

        return CGPoint(x: stepWidth, y: stepHeight)
    }
}
