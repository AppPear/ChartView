import SwiftUI

extension CGPoint {
	
	/// Calculate X and Y delta for each data point, based on data min/max and enclosing frame.
	/// - Parameters:
	///   - frame: Rectangle of enclosing frame
	///   - data: array of `Double`
	/// - Returns: X and Y delta as a `CGPoint`
    static func getStep(frame: CGRect, data: [Double]) -> CGPoint {
        guard data.count > 1 else {
            return .zero
        }

        guard let minPoint = data.min(), let maxPoint = data.max(), minPoint != maxPoint else {
            return .zero
        }

        let padding: CGFloat = 0
        let stepWidth = frame.size.width / CGFloat(data.count - 1)
        let stepHeight: CGFloat

        if minPoint <= 0 {
            stepHeight = (frame.size.height - padding) / CGFloat(maxPoint - minPoint)
        } else {
            stepHeight = (frame.size.height - padding) / CGFloat(maxPoint + minPoint)
        }

        return CGPoint(x: stepWidth, y: stepHeight)
    }
    
    func denormalize(with geometry: GeometryProxy) -> CGPoint {
        let frame = geometry.frame(in: .local).sanitized
        let width = frame.width
        let height = frame.height
        return CGPoint(x: self.x * width, y: self.y * height)
    }
}
