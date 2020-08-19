import SwiftUI

/// <#Description#>
public struct ColorGradient: Equatable {
	/// <#Description#>
	public let startColor: Color
	/// <#Description#>
    public let endColor: Color

	/// <#Description#>
	/// - Parameter color: <#color description#>
    public init(_ color: Color) {
        self.startColor = color
        self.endColor = color
    }

	/// <#Description#>
	/// - Parameters:
	///   - startColor: <#startColor description#>
	///   - endColor: <#endColor description#>
    public init(_ startColor: Color, _ endColor: Color) {
        self.startColor = startColor
        self.endColor = endColor
    }

/// <#Description#>
	/// - Returns: the coordinate for a rectangle center
    public var gradient: Gradient {
        return Gradient(colors: [startColor, endColor])
    }
}

extension ColorGradient {
    /// Convenience method to return a LinearGradient from the ColorGradient
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
