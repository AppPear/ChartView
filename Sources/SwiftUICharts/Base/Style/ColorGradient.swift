import SwiftUI

public struct ColorGradient {
    public let startColor: Color
    public let endColor: Color

    public init (_ startColor: Color, _ endColor: Color) {
        self.startColor = startColor
        self.endColor = endColor
    }

    public var gradient: Gradient {
        return Gradient(colors: [startColor, endColor])
    }
}
