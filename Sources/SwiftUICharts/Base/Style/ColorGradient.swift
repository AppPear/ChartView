import SwiftUI

public struct ColorGradient: Equatable {
	public let startColor: Color
    public let endColor: Color

    public init(_ color: Color) {
        self.startColor = color
        self.endColor = color
    }

    public init(_ startColor: Color, _ endColor: Color) {
        self.startColor = startColor
        self.endColor = endColor
    }

    public var gradient: Gradient {
        return Gradient(colors: [startColor, endColor])
    }
}

extension ColorGradient {
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
