import SwiftUI

public struct ChartStyle {
    public let backgroundColor: ColorGradient
    public let foregroundColor: [ColorGradient]

    public init(backgroundColor: Color, foregroundColor: [ColorGradient]) {
        self.backgroundColor = ColorGradient(backgroundColor)
        self.foregroundColor = foregroundColor
    }

    public init(backgroundColor: Color, foregroundColor: ColorGradient) {
        self.backgroundColor = ColorGradient(backgroundColor)
        self.foregroundColor = [foregroundColor]
    }

    public init(backgroundColor: ColorGradient, foregroundColor: ColorGradient) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = [foregroundColor]
    }

    public init(backgroundColor: ColorGradient, foregroundColor: [ColorGradient]) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
}

public extension ChartStyle {
    static var highContrast: ChartStyle {
        ChartStyle(backgroundColor: Color.primary.opacity(0.12),
                   foregroundColor: [
                    ColorGradient(.yellow, .orange),
                    ColorGradient(.blue, .purple),
                    ColorGradient(.green, .yellow),
                    ColorGradient(.pink, .purple)
                   ])
    }

    static var highContrastMono: ChartStyle {
        ChartStyle(backgroundColor: Color.primary.opacity(0.15),
                   foregroundColor: ColorGradient(.white, .primary))
    }
}
