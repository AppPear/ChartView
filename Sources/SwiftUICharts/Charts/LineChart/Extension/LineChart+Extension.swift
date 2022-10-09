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

    public func showChartMarks(_ show: Bool) -> LineChart {
        self.chartProperties.showChartMarks = show
        return self
    }

    public func setLineStyle(to style: LineStyle) -> LineChart {
        self.chartProperties.lineStyle = style
        return self
    }
}
