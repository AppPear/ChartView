import SwiftUI

public struct ChartLineConfig {
    public var lineWidth: CGFloat
    public var backgroundGradient: ColorGradient?
    public var showChartMarks: Bool
    public var customChartMarksColors: ColorGradient?
    public var lineStyle: LineStyle
    public var animationEnabled: Bool

    public init(lineWidth: CGFloat = 2.0,
                backgroundGradient: ColorGradient? = nil,
                showChartMarks: Bool = true,
                customChartMarksColors: ColorGradient? = nil,
                lineStyle: LineStyle = .curved,
                animationEnabled: Bool = true) {
        self.lineWidth = lineWidth
        self.backgroundGradient = backgroundGradient
        self.showChartMarks = showChartMarks
        self.customChartMarksColors = customChartMarksColors
        self.lineStyle = lineStyle
        self.animationEnabled = animationEnabled
    }
}
