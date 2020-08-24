import SwiftUI

/// An encapsulation of a simple gradient between one color and another
public struct ColorGradient: Equatable {
	public let startColor: Color
    public let endColor: Color

	/// Initialize as a solid color
	/// - Parameter color: a  single `Color` (no gradient effect visible)
    public init(_ color: Color) {
        self.startColor = color
        self.endColor = color
    }

	/// Initialize a color gradient from two specified colors
	/// - Parameters:
	///   - startColor: starting color
	///   - endColor: ending color
    public init(_ startColor: Color, _ endColor: Color) {
        self.startColor = startColor
        self.endColor = endColor
    }

	/// Convert to a  `Gradient` object (more complicated than just two colors)
	/// - Returns: a `Gradient` between the specified start and end colors
    public var gradient: Gradient {
        return Gradient(colors: [startColor, endColor])
    }
}

extension ColorGradient {
    /// Convenience method to return a SwiftUI LinearGradient view from the ColorGradient
    /// - Parameters:
    ///   - startPoint: starting point
    ///   - endPoint: ending point
    /// - Returns: a Linear gradient
    public func linearGradient(from startPoint: UnitPoint, to endPoint: UnitPoint) -> LinearGradient {
        return LinearGradient(gradient: self.gradient, startPoint: startPoint, endPoint: endPoint)
    }
}

extension ColorGradient {
    public static let orangeBright = ColorGradient(ChartColors.orangeBright)
    public static let redBlack = ColorGradient(.red, .black)
    public static let greenRed = ColorGradient(.green, .red)
    public static let whiteBlack = ColorGradient(.white, .black)
}
