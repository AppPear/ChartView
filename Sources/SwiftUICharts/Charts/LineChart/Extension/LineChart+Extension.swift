import SwiftUI

extension LineChart {
    public func setLineWidth(width: CGFloat) -> LineChart {
        self.chartProperties.lineWidth = width
        return self
    }

    public func setBackground(colorGradient: ColorGradient) -> LineChart {
        self.chartProperties.backgroundGradient = colorGradient
        return self
    }

    public func showChartMarks(_ show: Bool, with color: ColorGradient? = nil) -> LineChart {
        self.chartProperties.showChartMarks = show
        self.chartProperties.customChartMarksColors = color
        return self
    }

    public func setLineStyle(to style: LineStyle) -> LineChart {
        self.chartProperties.lineStyle = style
        return self
    }

    public func withAnimation(_ enabled: Bool) -> LineChart {
        self.chartProperties.animationEnabled = enabled
        return self
    }
}
