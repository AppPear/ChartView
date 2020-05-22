import SwiftUI

public struct ChartStyle {
    public let backgroundColor: Color
    public let foregroundColor: ColorGradient

    public init(backgroundColor: Color, foregroundColor: ColorGradient) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
}
